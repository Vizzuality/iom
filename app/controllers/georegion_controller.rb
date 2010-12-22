class GeoregionController < ApplicationController

  layout 'site_layout'

  def show
    if(request.url.match(/countries/))
      @area = Country.find(params[:id], :select => Country.custom_fields)

      @projects = Project.custom_find(@site, :country => @area.name, :per_page => 10, :page => params[:page], :order => 'created_at DESC')

      @area_parent = "America"

      sql="select c.id,count(ps.project_id) as count,c.name,x(ST_Centroid(c.the_geom)) as lon,y(ST_Centroid(c.the_geom)) as lat,
        ST_AsGeoJSON(c.the_geom,6) as geojson
        from (countries_projects as cp inner join projects_sites as ps on cp.project_id=ps.project_id and site_id=#{@site.id})
        inner join countries as c on cp.country_id=c.id and c.id=#{params[:id].gsub(/\\/, '\&\&').gsub(/'/, "''")}
        group by c.id,c.name,lon,lat,geojson"
    else
      @area = Region.find(params[:id], :select => Region.custom_fields)

      @projects = Project.custom_find(@site, :region => @area.name, :per_page => 10, :page => params[:page], :order => 'created_at DESC')

      @area_parent = Country.find_by_id(@area.country_id, :select => "id, name").try(:name)
      sql="select r.id,count(ps.project_id) as count,r.name,x(ST_Centroid(r.the_geom)) as lon,y(ST_Centroid(r.the_geom)) as lat,
        ST_AsGeoJSON(r.the_geom,6) as geojson
        from (projects_regions as pr inner join projects_sites as ps on pr.project_id=ps.project_id and site_id=#{@site.id})
        inner join regions as r on pr.region_id=r.id and r.id=#{params[:id].gsub(/\\/, '\&\&').gsub(/'/, "''")}
        group by r.id,r.name,lon,lat,geojson"
    end

    respond_to do |format|
      format.html do
        result=ActiveRecord::Base.connection.execute(sql)
        @map_data = result.first
        @georegion_map_chco = @site.theme.data[:georegion_map_chco]
        @georegion_map_chf = @site.theme.data[:georegion_map_chf]
        @georegion_map_marker_source = @site.theme.data[:georegion_map_marker_source]
        @georegion_map_stroke_color = @site.theme.data[:georegion_map_stroke_color]
        @georegion_map_fill_color = @site.theme.data[:georegion_map_fill_color]

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

        @first_three = @area.projects_clusters(@site)[0...3]
        @first_three_max = @first_three.map{|g, c| c}.sort.last
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