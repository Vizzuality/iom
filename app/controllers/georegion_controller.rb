class GeoregionController < ApplicationController

  layout 'site_layout'

  def show
    if(request.url.match(/countries/))
      @area = Country.find(params[:id])
      @area_parent = "America"
      
      sql="select c.id,count(ps.project_id) as count,c.name,x(ST_Centroid(c.the_geom)) as lon,y(ST_Centroid(c.the_geom)) as lat,
        ST_AsGeoJSON(c.the_geom,6) as geojson
        from (countries_projects as cp inner join projects_sites as ps on cp.project_id=ps.project_id and site_id=#{@site.id}) 
        inner join countries as c on cp.country_id=c.id and c.id=#{params[:id].gsub(/\\/, '\&\&').gsub(/'/, "''")}
        group by c.id,c.name,lon,lat,geojson"
    else
      @area = Region.find(params[:id])
      @area_parent = @area.country.try(:name)
      sql="select r.id,count(ps.project_id) as count,r.name,x(ST_Centroid(r.the_geom)) as lon,y(ST_Centroid(r.the_geom)) as lat,
        ST_AsGeoJSON(r.the_geom,6) as geojson
        x(ST_PointN(ST_ExteriorRing(ST_Envelope(r.the_geom)),2)) as maxx
        from (projects_regions as pr inner join projects_sites as ps on pr.project_id=ps.project_id and site_id=#{@site.id}) 
        inner join regions as r on pr.region_id=r.id and r.id=#{params[:id].gsub(/\\/, '\&\&').gsub(/'/, "''")}
        group by r.id,r.name,lon,lat,geojson"
    end
    
    @map_data = ActiveRecord::Base.connection.execute(sql).first
    @georegion_map_chco = "F7F7F7,8BC856,336600"
    @georegion_map_chf = "bg,s,2F84A3"
    @georegion_map_marker_source = ""
    @georegion_map_stroke_color = "#FFFFFF"    
    @georegion_map_fill_color = "#FFFFFF"    
    
    @projects = @area.projects.site(@site).where("id IN (#{@site.projects_ids.join(',')})").paginate :per_page => 10, :page => params[:page], :order => 'created_at DESC'    

    respond_to do |format|
      format.html {render :show}
      format.js do
        render :update do |page|
          page << "$('#projects_view_more').remove();"
          page << "$('#projects').append('#{escape_javascript(render(:partial => 'projects/projects'))}');"
          page << "IOM.ajax_pagination();"
        end
      end
    end
    
  end

end