class SitesController < ApplicationController

  layout :sites_layout

  def home
    if(@site)
      site_home
    else
      general_home
    end
    return
  end

  def general_home
    @sites = Site.paginate :per_page => 20, :page => params[:page], :order => 'created_at DESC'

    render :general_home
  end

  def site_home
    # Get the data for the map depending on the region definition of the site (country or region)
    if(@site.geographic_context_country_id)
      sql="select r.id,count(ps.project_id) as count,r.name,x(ST_Centroid(r.the_geom)) as lon,
          y(ST_Centroid(r.the_geom)) as lat,r.name,'/regions/'||r.id as url
          from ((projects_regions as pr inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{@site.id})
          inner join regions as r on pr.region_id=r.id and r.level=3)
          inner join countries as c on r.country_id=c.id
          group by r.id,r.name,lon,lat,c.name,url"
    else
      sql="select c.id,count(ps.project_id) as count,c.name,x(ST_Centroid(c.the_geom)) as lon,y(ST_Centroid(c.the_geom)) as lat,
          '/countries/'||c.id as url
          from (countries_projects as cp inner join projects_sites as ps on cp.project_id=ps.project_id and site_id=#{@site.id})
          inner join countries as c on cp.country_id=c.id
          group by c.id,c.name,lon,lat"
    end

    @map_data=ActiveRecord::Base.connection.execute(sql).to_json
    @map_data_total_count=23323
    @overview_map_bbox = [{:lat => 18.93205126204314,:lon => -72.6361083984375}, {:lat => 18.7,:lon => -72.636108398437}]
    @overview_map_chco = "F7F7F7,8BC856,336600"
    @overview_map_chf = "bg,s,2F84A3"
    @overview_map_marker_source = ""


    @projects = @site.projects.paginate :per_page => 10, :page => params[:page], :order => 'created_at DESC'

    render :site_home
  end

  def about

  end

  def contact

  end

  def sites_layout
    @site ? 'site_layout' : 'root_layout'
  end
  private :sites_layout
end
