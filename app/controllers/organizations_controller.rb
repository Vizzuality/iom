class OrganizationsController < ApplicationController

  layout :sites_layout

  def index
    @organizations = @site.organizations
  end

  def show
    unless @organization = @site.organizations.select{ |org| org.id == params[:id].to_i }.first
      raise ActiveRecord::RecordNotFound
    end
    @organization.attributes = @organization.attributes_for_site(@site)

    @filter_by_category = params[:category_id].to_i
    @filter_by_location = params[:location_id].split('/').map(&:to_i) if params[:location_id] && params[:location_id].is_a?(String)

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
        "#{region.country.name}/#{region.name}" rescue ''
      end
      @filter_name =  "#{@category_name} projects in #{@location_name}"
    elsif @filter_by_location
      @location_name = if @filter_by_location.size == 1
        "#{Country.where(:id => @filter_by_location.first).first.name}"
      else
        region = Region.where(:id => @filter_by_location.last).first
        "#{region.country.name}/#{region.name}" rescue ''
      end
      @filter_name = "projects in #{@location_name}"
    elsif filter_by_category_valid?
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
    projects_custom_find_options[:organization_category_id] = @filter_by_category if filter_by_category_valid?
    if @filter_by_location.present?
      if @filter_by_location.size > 1
        projects_custom_find_options[:organization_region_id] = @filter_by_location.last
      else
        projects_custom_find_options[:organization_country_id] = @filter_by_location.first
      end
    end

    @projects = Project.custom_find @site, projects_custom_find_options

    @organization_projects_count            = @organization.projects_count(@site, @filter_by_category, @filter_by_location)
    @organization_projects_clusters_sectors = @organization.projects_clusters_sectors(@site, @filter_by_location)
    @organization_projects_by_location = if @site.navigate_by_country?
      @organization.projects_countries(@site, @filter_by_category)
    else
      @organization.projects_regions(@site, @filter_by_category)
    end

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


          sql="select r.id,count(distinct ps.project_id) as count,r.name,r.center_lon as lon,r.center_lat as lat,
                      CASE WHEN count(distinct ps.project_id) > 1 THEN
                          '#{carry_on_url}'||r.path
                      ELSE
                          '/projects/'||(array_to_string(array_agg(ps.project_id),''))
                      END as url

                      ,r.code,
                      (select count(*) from data_denormalization where regions_ids && ('{'||r.id||'}')::integer[] and (end_date is null OR end_date > now()) and site_id=#{@site.id}) as total_in_region
                from ((((
                  projects as p inner join organizations as o on o.id=p.primary_organization_id and
                  o.id=#{params[:id].sanitize_sql!.to_i})
                  inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{@site.id})
                  inner join projects as prj on ps.project_id=prj.id and (prj.end_date is null OR prj.end_date > now())
                  inner join projects_regions as pr on pr.project_id=p.id)
                  inner join regions as r on pr.region_id=r.id and r.level=#{@site.level_for_region} #{location_filter})
                  #{category_join}
                group by r.id,r.path,lon,lat,r.name,r.code"
        else
          if @filter_by_location
            location_filter = @filter_by_location.size == 1 ? "r.country_id = #{@filter_by_location.first}" : "r.id = #{@filter_by_location.last}"

            sql="select c.id,count(distinct ps.project_id) as count,c.name,c.center_lon as lon,
                        c.center_lat as lat,c.name,
                        CASE WHEN count(distinct ps.project_id) > 1 THEN
                            '#{carry_on_url}'||c.id
                        ELSE
                            '/projects/'||(array_to_string(array_agg(ps.project_id),''))
                        END as url,
                        c.iso2_code as code,
                        (select count(*) from data_denormalization where countries_ids && ('{'||c.id||'}')::integer[] and (end_date is null OR end_date > now()) and site_id=#{@site.id}) as total_in_region
                  from (((((
                    projects as p inner join organizations as o on o.id=p.primary_organization_id and o.id=#{params[:id].sanitize_sql!.to_i})
                    inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{@site.id}) inner join countries_projects as cp on cp.project_id=p.id)
                    inner join projects as prj on ps.project_id=prj.id and (prj.end_date is null OR prj.end_date > now())
                    inner join countries as c on cp.country_id=c.id)
                    inner join regions as r on r.country_id=c.id)
                    #{category_join}
                    where #{location_filter} and r.level=#{@site.level_for_region}
                    group by c.id,c.name,lon,lat,c.name,c.iso2_code"
          else
            sql="select c.id,count(distinct ps.project_id) as count,c.name,c.center_lon as lon,
                        c.center_lat as lat,c.name,
                        CASE WHEN count(distinct ps.project_id) > 1 THEN
                            '#{carry_on_url}'||c.id
                        ELSE
                            '/projects/'||(array_to_string(array_agg(ps.project_id),''))
                        END as url,
                        c.iso2_code as code,
                        (select count(*) from data_denormalization where countries_ids && ('{'||c.id||'}')::integer[] and (end_date is null OR end_date > now()) and site_id=#{@site.id}) as total_in_region
                  from ((((
                    projects as p inner join organizations as o on o.id=p.primary_organization_id and o.id=#{params[:id].sanitize_sql!.to_i})
                    inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{@site.id}) inner join countries_projects as cp on cp.project_id=p.id)
                    inner join projects as prj on ps.project_id=prj.id and (prj.end_date is null OR prj.end_date > now())
                    inner join countries as c on cp.country_id=c.id)
                    #{category_join}
                  group by c.id,c.name,lon,lat,c.name,c.iso2_code"
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
          page << "$('#projects').html('#{escape_javascript(render(:partial => 'projects/projects'))}');"
          page << "IOM.ajax_pagination();"
          page << "resizeColumn();"
        end
      end
      format.csv do
        send_data Project.to_csv(@site, projects_custom_find_options),
          :type => 'text/plain; charset=utf-8; application/download',
          :disposition => "attachment; filename=#{@organization.name}_projects.csv"
      end
      format.xls do
        send_data Project.to_excel(@site, projects_custom_find_options),
          :type        => 'application/vnd.ms-excel',
          :disposition => "attachment; filename=#{@organization.name}_projects.xls"
      end
      format.kml do
        @projects_for_kml = Project.to_kml(@site, projects_custom_find_options)
      end
    end
  end

  private
  def filter_by_category_valid?
    @filter_by_category.present? && @filter_by_category.to_i > 0
  end

end
