class OrganizationsController < ApplicationController

  layout 'site_layout'

  def index
    @organizations = @site.organizations
  end

  def show
    unless @organization = @site.organizations.select{ |org| org.id == params[:id].to_i }.first
      raise ActiveRecord::RecordNotFound
    end
    @organization.attributes = @organization.attributes_for_site(@site)

    @filter_by_category = params[:category_id]
    @filter_by_location = params[:location_id].split('/') if params[:location_id]

    @carry_on_filters = {}
    @carry_on_filters[:category_id] = params[:category_id] if params[:category_id].present?
    @carry_on_filters[:location_id] = params[:location_id] if params[:location_id].present?

    @filter_name = ''

    if @filter_by_category && @filter_by_location
      @category_name =  "#{(@site.navigate_by_sector?? Sector : Cluster).where(:id => @filter_by_category).first.name}"
      @location_name = if @filter_by_location.size == 1
        "#{Country.where(:id => @filter_by_location.first).first.name}"
      else
        region = Region.where(:id => @filter_by_location.last).first
        "#{region.country.name}/#{region.name}"
      end
      @filter_name =  "#{@category_name} projects in #{@location_name}"
    elsif @filter_by_location
      @location_name = if @filter_by_location.size == 1
        "#{Country.where(:id => @filter_by_location.first).first.name}"
      else
        region = Region.where(:id => @filter_by_location.last).first
        "#{region.country.name}/#{region.name}"
      end
      @filter_name = "projects in #{@location_name}"
    elsif @filter_by_category.present?
      @category_name = (@site.navigate_by_sector?? Sector : Cluster).where(:id => @filter_by_category).first.name
      @filter_name =  "#{@category_name} projects"
    end

    projects_custom_find_options = {
      :organization  => @organization.id,
      :per_page      => 10,
      :page          => params[:page],
      :order         => 'created_at DESC',
      :start_in_page => params[:start_in_page]
    }
    projects_custom_find_options[:organization_category_id] = @filter_by_category if @filter_by_category.present?
    if @filter_by_location.present?
      if @filter_by_location.size > 1
        projects_custom_find_options[:organization_region_id] = @filter_by_location.last
      else
        projects_custom_find_options[:organization_country_id] = @filter_by_location.first
      end
    end

    @organization_projects_count            = @organization.projects_count(@site, @filter_by_category, @filter_by_location)
    @organization_projects_clusters_sectors = @organization.projects_clusters_sectors(@site, @filter_by_location)
    @organization_projects_by_location = if @site.navigate_by_country?
      @organization.projects_countries(@site, @filter_by_category)
    else
      @organization.projects_regions(@site, @filter_by_category)
    end

    @projects = Project.custom_find @site, projects_custom_find_options
    respond_to do |format|
      format.html do

        if @filter_by_category.present?
          if @site.navigate_by_cluster?
            category_join = "inner join clusters_projects as cp on cp.project_id = p.id and cp.cluster_id = #{@filter_by_category}"
          else
            category_join = "inner join projects_sectors as pse on pse.project_id = p.id and pse.sector_id = #{@filter_by_category}"
          end
        end

        #Map data
        carry_on_url = organization_path(@organization, @carry_on_filters.merge(:location_id => ''))
        if @site.geographic_context_country_id

          location_filter = "and r.id = #{@filter_by_location.last}" if @filter_by_location


          sql="select r.id,count(ps.project_id) as count,r.name,r.center_lon as lon,r.center_lat as lat,
                      r.name,'#{carry_on_url}'||r.path as url,r.code,
                      (select count(*) from data_denormalization where regions_ids && ('{'||r.id||'}')::integer[] and (end_date is null OR end_date > now()) and site_id=#{@site.id}) as total_in_region
                from ((((
                  projects as p inner join organizations as o on o.id=p.primary_organization_id and
                  o.id=#{params[:id].sanitize_sql!})
                  inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{@site.id})
                  inner join projects as prj on ps.project_id=prj.id and (prj.end_date is null OR prj.end_date > now())
                  inner join projects_regions as pr on pr.project_id=p.id)
                  inner join regions as r on pr.region_id=r.id and r.level=#{@site.level_for_region} #{location_filter})
                  #{category_join}
                group by r.id,r.name,lon,lat,r.name,url,r.code"
        else
          if @filter_by_location
            location_filter = @filter_by_location.size == 1 ? "r.country_id = #{@filter_by_location.first}" : "r.id = #{@filter_by_location.last}"

            sql="select r.id,r.name,count(ps.*) as count,r.center_lon as lon,r.center_lat as lat,'#{carry_on_url}'||r.path as url,
                (select count(*) from data_denormalization where regions_ids && ('{'||r.id||'}')::integer[] and (end_date is null OR end_date > now()) and site_id=#{@site.id}) as total_in_region
            from regions as r
              inner join projects_regions as pr on r.id=pr.region_id
              inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{@site.id}
              inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
              inner join organizations as o on o.id=p.primary_organization_id and o.id=#{params[:id].sanitize_sql!}
              #{category_join}
              where #{location_filter}
              group by r.id,r.name,lon,lat,url"
          else
            sql="select c.id,count(ps.project_id) as count,c.name,c.center_lon as lon,
                        c.center_lat as lat,c.name,'#{carry_on_url}'||c.id as url,c.iso2_code as code,
                        (select count(*) from data_denormalization where countries_ids && ('{'||c.id||'}')::integer[] and (end_date is null OR end_date > now()) and site_id=#{@site.id}) as total_in_region
                  from ((((
                    projects as p inner join organizations as o on o.id=p.primary_organization_id and o.id=#{params[:id].sanitize_sql!})
                    inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{@site.id}) inner join countries_projects as cp on cp.project_id=p.id)
                    inner join projects as prj on ps.project_id=prj.id and (prj.end_date is null OR prj.end_date > now())
                    inner join countries as c on cp.country_id=c.id)
                    #{category_join}
                  group by c.id,c.name,lon,lat,c.name,url,c.iso2_code"
          end

        end

        result=ActiveRecord::Base.connection.execute(sql)
        @map_data = result.map do |r|
          r['url'] = r['url'] + "?force_site_id=#{@site.id}" unless @site.published?
          r
        end.to_json
        @overview_map_chco = @site.theme.data[:overview_map_chco]
        @overview_map_chf = @site.theme.data[:overview_map_chf]
        @overview_map_marker_source = @site.theme.data[:overview_map_marker_source]

        areas= []
        data = []
        @map_data_max_count=0
        result.each do |c|
          areas << c["code"]
          data  << c["count"]
          if(@map_data_max_count < c["count"].to_i)
            @map_data_max_count=c["count"].to_i
          end
        end
        #@chld = areas.join("|")
        @chld = ""
        #@chd  = "t:"+data.join(",")
        @chd = ""
      end
      format.js do
        render :update do |page|
          page << "$('#projects_view_more').remove();"
          page << "$('#projects').append('#{escape_javascript(render(:partial => 'projects/projects'))}');"
          page << "IOM.ajax_pagination();"
          page << "resizeColumn();"
        end
      end
      format.csv do
        projects_for_csv = @organization.projects_for_csv(@site)
        headers = projects_for_csv.any?? projects_for_csv.first.keys : nil

        send_data projects_for_csv.serialize_to_csv(:headers => headers),
          :type => 'text/plain; charset=utf-8; application/download',
          :disposition => "attachment; filename=#{@organization.name}_projects.csv"
      end
      format.xls do
        projects_for_csv = @organization.projects_for_csv(@site)
        headers = projects_for_csv.any?? projects_for_csv.first.keys : nil

        send_data projects_for_csv.to_excel(:headers => headers),
          :type        => 'application/vnd.ms-excel',
          :disposition => "attachment; filename=#{@organization.name}_projects.xls"
      end
      format.kml do
        @projects_for_kml = @organization.projects_for_kml(@site)
      end
    end
  end

end