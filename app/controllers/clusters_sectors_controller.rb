class ClustersSectorsController < ApplicationController

  layout 'site_layout'

  def show
    @filter_by_location = params[:location_id].split('/') if params[:location_id]

    @carry_on_filters = {}
    @carry_on_filters[:location_id] = params[:location_id] if params[:location_id].present?

    if @filter_by_location
      @location_name = if @site.navigate_by_country?
        "#{Country.where(:id => @filter_by_location.first).first.name}"
      else
        region = Region.where(:id => @filter_by_location.last).first
        "#{region.country.name}/#{region.name}"
      end
      @filter_name = "projects in #{@location_name}"
    end

    if(request.url.match(/clusters/))
      # clusters
      render_404 and return unless @site.navigate_by_cluster?
      @data = Cluster.find(params[:id])

      projects_custom_find_options = {
        :cluster       => @data.id,
        :per_page      => 10,
        :page          => params[:page],
        :order         => 'created_at DESC',
        :start_in_page => params[:start_in_page]
      }

      projects_custom_find_options[:cluster_location_id] = @filter_by_location.last if @filter_by_location.present?
    else
      # sectors
      render_404 and return unless @site.navigate_by_sector?
      @data = Sector.find(params[:id])

      projects_custom_find_options = {
        :sector        => @data.id,
        :per_page      => 10,
        :page          => params[:page],
        :order         => 'created_at DESC',
        :start_in_page => params[:start_in_page]
      }

      projects_custom_find_options[:sector_location_id] = @filter_by_location.last if @filter_by_location.present?
    end

    @projects = Project.custom_find @site, projects_custom_find_options

    @cluster_sector_projects_count = @data.total_projects(@site, @filter_by_location)


    respond_to do |format|
      format.html do

        if @data.is_a?(Cluster)
          carry_on_url = cluster_path(@data, @carry_on_filters.merge(:location_id => ''))
          if @site.geographic_context_country_id
            location_filter = "where r.id = #{@filter_by_location.last}" if @filter_by_location

            # Get the data for the map depending on the region definition of the site (country or region)
            sql="select r.id,r.name,count(ps.*) as count,r.center_lon as lon,r.center_lat as lat,r.name,'#{carry_on_url}'||r.path as url,r.code,
                (select count(*) from data_denormalization where regions_ids && ('{'||r.id||'}')::integer[] and is_active=true and site_id=#{@site.id}) as total_in_region
            from regions as r
              inner join projects_regions as pr on r.id=pr.region_id and r.level=#{@site.level_for_region}
              inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{@site.id}
              inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
              inner join clusters_projects as cp on cp.project_id=p.id and cp.cluster_id=#{params[:id].sanitize_sql!}
              #{location_filter}
              group by r.id,r.name,lon,lat,r.name,url,r.code"
          else
             location_filter = "where c.id = #{@filter_by_location.first}" if @filter_by_location
             sql="select c.id,c.name,count(ps.*) as count,c.center_lon as lon,c.center_lat as lat,c.name,'#{carry_on_url}'||c.id as url,
                  (select count(*) from data_denormalization where countries_ids && ('{'||c.id||'}')::integer[] and is_active=true and site_id=#{@site.id}) as total_in_region
              from countries as c
                inner join countries_projects as cp on c.id=cp.country_id
                inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=#{@site.id}
                inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
                inner join clusters_projects as cpr on cpr.project_id=p.id and cpr.cluster_id=#{params[:id].sanitize_sql!}
                #{location_filter}
                group by c.id,c.name,lon,lat,c.name,url"
          end
        else
          carry_on_url = sector_path(@data, @carry_on_filters.merge(:location_id => ''))
          if @site.geographic_context_country_id
            location_filter = "where r.id = #{@filter_by_location.last}" if @filter_by_location

            # Get the data for the map depending on the region definition of the site (country or region)
            sql="select r.id,r.name,count(ps.*) as count,r.center_lon as lon,r.center_lat as lat,r.name,'#{carry_on_url}'||r.path as url,r.code,
                (select count(*) from data_denormalization where regions_ids && ('{'||r.id||'}')::integer[] and is_active=true and site_id=#{@site.id}) as total_in_region
            from regions as r
              inner join projects_regions as pr on r.id=pr.region_id and r.level=#{@site.level_for_region}
              inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{@site.id}
              inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
              inner join projects_sectors as pse on pse.project_id=p.id and pse.sector_id=#{params[:id].sanitize_sql!}
              #{location_filter}
              group by r.id,r.name,lon,lat,r.name,url,r.code"
          else
            location_filter = "where c.id = #{@filter_by_location.first}" if @filter_by_location

            sql="select c.id,c.name,count(ps.*) as count,c.center_lon as lon,c.center_lat as lat,c.name,'#{carry_on_url}'||c.id as url,
                (select count(*) from data_denormalization where countries_ids && ('{'||c.id||'}')::integer[] and is_active=true and site_id=#{@site.id}) as total_in_region
            from countries as c
              inner join countries_projects as cp on c.id=cp.country_id
              inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=#{@site.id}
              inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
              inner join projects_sectors as pse on pse.project_id=p.id and pse.sector_id=#{params[:id].sanitize_sql!}
              #{location_filter}
              group by c.id,c.name,lon,lat,c.name,url"
          end
        end

        result = ActiveRecord::Base.connection.execute(sql)
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
        projects_for_csv = @data.projects_for_csv(@site)
        headers = projects_for_csv.any?? projects_for_csv.first.keys : nil

        send_data projects_for_csv.serialize_to_csv(:headers => headers),
          :type => 'text/plain; charset=utf-8; application/download',
          :disposition => "attachment; filename=#{@data.name}_projects.csv"

      end
      format.kml do
        @projects_for_kml = @data.projects_for_kml(@site)
      end
    end
  end

end
