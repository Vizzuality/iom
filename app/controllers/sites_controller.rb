class SitesController < ApplicationController

  layout :sites_layout

  def home
    if @site
      site_home
    else
      general_home
    end
  end

  def general_home
    @sites = Site.published.paginate :per_page => 20, :page => params[:page], :order => 'id DESC'
    render :general_home
  end

  def site_home
    @projects = Project.custom_find @site, :per_page => 10,
                                           :page => params[:page],
                                           :start_in_page => params[:start_in_page]

    respond_to do |format|
      format.html do
        # Get the data for the map depending on the region definition of the site (country or region)
        if @site.geographic_context_country_id
          sql="select r.id,count(ps.project_id) as count,r.name,r.center_lon as lon,
                    r.center_lat as lat,r.name,'/location/'||r.path as url,r.code
                    from ((projects_regions as pr inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{@site.id})
                    inner join projects as p on pr.project_id=p.id and (p.end_date is null OR p.end_date > now())
                    inner join regions as r on pr.region_id=r.id and r.level=#{@site.level_for_region})
                    group by r.id,r.name,lon,lat,r.name,url,r.code"
        else
          sql="select c.id,count(ps.project_id) as count,c.name,c.center_lon as lon,
                    c.center_lat as lat,
                    '/location/'||c.id as url,iso2_code as code
                    from countries_projects as cp
                    inner join projects_sites as ps on cp.project_id=ps.project_id and site_id=#{@site.id}
                    inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
                    inner join countries as c on cp.country_id=c.id
                    group by c.id,c.name,lon,lat,iso2_code"
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
        @chld = areas.join("|")
        @chd  = "t:"+data.join(",")
        render request.fullpath.match('home2') ? :site_home2 : :site_home
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
        projects_for_csv = @site.projects_for_csv
        headers = projects_for_csv.any?? projects_for_csv.first.keys : nil

        send_data projects_for_csv.serialize_to_csv(:headers => headers),
          :type => 'text/plain; charset=utf-8; application/download',
          :disposition => "attachment; filename=#{@site.name}_projects.csv"
      end
      format.kml do
        debugger
        @projects_for_kml = @site.projects_for_kml

        render :site_home
      end
    end
  end

  def about
  end

  def about_interaction
  end

  def contact
  end

  def sites_layout
    @site ? 'site_layout' : 'root_layout'
  end
  private :sites_layout

end
