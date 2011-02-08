class ClustersSectorsController < ApplicationController

  layout 'site_layout'

  def show
    if(request.url.match(/clusters/))
      # clusters
      render_404 and return unless @site.navigate_by_cluster?
      @data = Cluster.find(params[:id])
      @projects = Project.custom_find @site, :cluster => @data.id,
                                             :per_page => 10,
                                             :page => params[:page],
                                             :order => 'created_at DESC',
                                             :start_in_page => params[:start_in_page]
    else
      # sectors
      render_404 and return unless @site.navigate_by_sector?
      @data = Sector.find(params[:id])
      @projects = Project.custom_find @site, :sector => @data.id,
                                             :per_page => 10,
                                             :page => params[:page],
                                             :order => 'created_at DESC',
                                             :start_in_page => params[:start_in_page]
    end

    respond_to do |format|
      format.html do
        if @data.is_a?(Cluster)
          # Get the data for the map depending on the region definition of the site (country or region)
          sql="select r.id,r.name,count(ps.*) as count,r.center_lon as lon,r.center_lat as lat,r.name,'/location/'||r.path as url,r.code,
              (select count(*) from data_denormalization where regions_ids && ('{'||r.id||'}')::integer[] and is_active=true and site_id=#{@site.id}) as total_in_region
          from regions as r
            inner join projects_regions as pr on r.id=pr.region_id and r.level=#{@site.level_for_region}
            inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{@site.id}
            inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
            inner join clusters_projects as cp on cp.project_id=p.id and cp.cluster_id=#{params[:id].sanitize_sql!}
            group by r.id,r.name,lon,lat,r.name,url,r.code"
        else
          # Get the data for the map depending on the region definition of the site (country or region)
          sql="select r.id,r.name,count(ps.*) as count,r.center_lon as lon,r.center_lat as lat,r.name,'/location/'||r.path as url,r.code,
              (select count(*) from data_denormalization where regions_ids && ('{'||r.id||'}')::integer[] and is_active=true and site_id=#{@site.id}) as total_in_region
          from regions as r
            inner join projects_regions as pr on r.id=pr.region_id and r.level=#{@site.level_for_region}
            inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{@site.id}
            inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
            inner join projects_sectors as pse on pse.project_id=p.id and pse.sector_id=#{params[:id].sanitize_sql!}
            group by r.id,r.name,lon,lat,r.name,url,r.code"
        end

        result=ActiveRecord::Base.connection.execute(sql)
        @map_data=result.to_json
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
    end
  end

end