class GeoregionController < ApplicationController

  layout 'site_layout'

  def show
    render_404 and return if params[:ids].blank?
    render_404 and return unless params[:ids] =~ /([\d|\/]+)/
    render_404 and return unless $1.size == params[:ids].size

    geo_ids = params[:ids].split('/')

    @breadcrumb = []

    @country = @area = country = Country.find(geo_ids[0], :select => Country.custom_fields)
    render_404 and return unless country

    @breadcrumb << country if @site.navigate_by_country?

    if geo_ids.size == 1
      @projects = Project.custom_find @site, :country => country.name,
                                             :level => 1,
                                             :per_page => 10,
                                             :page => params[:page],
                                             :order => 'created_at DESC',
                                             :start_in_page => params[:start_in_page]

      # TODO
      @area_parent = "America"

      sql="select *,
        (select the_geom_geojson from regions where id=subq.id) as geojson
        from(
        select c.id,count(ps.project_id) as count,c.name,c.center_lon as lon,c.center_lat as lat
        from (countries_projects as cp
          inner join projects_sites as ps on cp.project_id=ps.project_id and site_id=#{@site.id})
          inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
          inner join countries as c on cp.country_id=c.id and c.id=#{country.id}
        group by c.id,c.name,lon,lat) as subq"
    else
      level = 1
      geo_ids[1..-1].each do |geo_id|
        region = Region.find(geo_id, :select => Region.custom_fields, :conditions => {:level => level, :country_id => country.id})
        render_404 and return unless region
        @breadcrumb << region unless !@site.send("navigate_by_level#{level}?".to_sym)
        @area = region
        level += 1
      end
    end

    render_404 if @area.is_a?(Region) && !@site.send("navigate_by_level#{@area.level}?".to_sym)

    if @area.is_a?(Region)
      @projects = Project.custom_find @site, :region => @area.id,
                                             :level => @area.level,
                                             :per_page => 10,
                                             :page => params[:page],
                                             :order => 'created_at DESC',
                                             :start_in_page => params[:start_in_page]

      @area_parent = country.name

      # If we are in the main level whe only show the projects of 
      # this level
      if @area.level == @site.levels_for_region.max
        sql="select *,(select the_geom_geojson from regions where id=subq.id) as geojson
          from(
          select r.id,count(ps.project_id) as count,r.name,r.center_lon as lon,r.center_lat as lat
          from (projects_regions as pr
            inner join projects_sites as ps on pr.project_id=ps.project_id and site_id=#{@site.id})
            inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
            inner join regions as r on pr.region_id=r.id and r.id=#{@area.id} and r.level=#{@area.level}
          group by r.id,r.name,lon,lat) as subq"
      else
        sql="select *,(select the_geom_geojson from regions where id=subq.id) as geojson
          from(
          select r.id,count(ps.project_id) as count,r.name,r.center_lon as lon,r.center_lat as lat
          from (projects_regions as pr
            inner join projects_sites as ps on pr.project_id=ps.project_id and site_id=#{@site.id})
            inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
            inner join regions as r on pr.region_id=r.id and r.parent_region_id=#{@area.id} and r.level=#{@area.level+1}
          group by r.id,r.name,lon,lat) as subq"
      end
    end

    render_404 and return if sql.nil?

    respond_to do |format|
      format.html do
        result = ActiveRecord::Base.connection.execute(sql)
        @map_data = result.first || {'id' => nil, 'lat' => nil, 'lon' => nil, 'count' => nil, 'geojson' => nil}
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
        @breadcrumb.pop
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

  def old_regions
    region = Region.find(params[:id], :select => Region.custom_fields)
    render_404 and return unless region
    redirect_to location_path(region), :status => 301
  end

end
