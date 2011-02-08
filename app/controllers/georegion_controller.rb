class GeoregionController < ApplicationController

  layout 'site_layout'

  skip_before_filter :set_site, :only => [:list_regions1_from_country,:list_regions2_from_country,:list_regions3_from_country]

  def show
    render_404 and return if params[:ids].blank?
    render_404 and return unless params[:ids] =~ /([\d|\/]+)/
    render_404 and return unless $1.size == params[:ids].size

    geo_ids = params[:ids].split('/')

    @breadcrumb = []

    @country = @area = country = Country.find(geo_ids[0], :select => Country.custom_fields)
    render_404 and return unless country

    @breadcrumb << country if @site.navigate_by_country?

    if geo_ids.size == 1 && @site.navigate_by_country?
      @projects = Project.custom_find @site, :country => country.id,
                                             :level => 1,
                                             :per_page => 10,
                                             :page => params[:page],
                                             :order => 'created_at DESC',
                                             :start_in_page => params[:start_in_page]

      # TODO
      @area_parent = ""

      if @site.navigate_by_regions?
        sql="select r.id,count(ps.project_id) as count,r.name,r.center_lon as lon,
                  r.center_lat as lat,r.name,'/location/'||r.path as url,r.code
                  from ((projects_regions as pr inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{@site.id})
                  inner join projects as p on pr.project_id=p.id and (p.end_date is null OR p.end_date > now())
                  inner join regions as r on pr.region_id=r.id and r.level=#{@site.levels_for_region.min} and r.country_id=#{country.id})
                  group by r.id,r.name,lon,lat,r.name,url,r.code"
      else
        sql="select *
          from(
          select c.id,count(ps.project_id) as count,c.name,c.center_lon as lon,c.center_lat as lat
          from (countries_projects as cp
            inner join projects_sites as ps on cp.project_id=ps.project_id and site_id=#{@site.id})
            inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
            inner join countries as c on cp.country_id=c.id and c.id=#{country.id}
          group by c.id,c.name,lon,lat) as subq"
      end
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
      @projects = Project.custom_find  @site,
                                       :region => @area.id,
                                       :level => @site.levels_for_region,
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
          select r.id,count(distinct(ps.project_id)) as count,r.name,r.center_lon as lon,r.center_lat as lat
          from (projects_regions as pr
            inner join projects_sites as ps on pr.project_id=ps.project_id and site_id=#{@site.id})
            inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
            inner join regions as r on pr.region_id=r.id and r.id=#{@area.id} and r.level=#{@area.level}
          group by r.id,r.name,lon,lat) as subq"
      else
        sql="select *,(select the_geom_geojson from regions where id=subq.id) as geojson
          from(
          select r.id,count(distinct(ps.project_id)) as count,r.name,r.center_lon as lon,r.center_lat as lat
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

        @georegion_map_chco = @site.theme.data[:georegion_map_chco]
        @georegion_map_chf = @site.theme.data[:georegion_map_chf]
        @georegion_map_marker_source = @site.theme.data[:georegion_map_marker_source]
        @georegion_map_stroke_color = @site.theme.data[:georegion_map_stroke_color]
        @georegion_map_fill_color = @site.theme.data[:georegion_map_fill_color]

        result = ActiveRecord::Base.connection.execute(sql)
        if @area.is_a?(Country) && @site.navigate_by_regions?
          @map_data = result.to_json
        else
          @map_data = result.first || {'id' => nil, 'lat' => nil, 'lon' => nil, 'count' => nil, 'geojson' => nil}
        end

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

        if @area.is_a?(Country) && @site.navigate_by_regions?
          bbox = LineString.from_points(result.map{ |r| Point.from_x_y(r['lon'].to_f, r['lat'].to_f)}).bounding_box
          @overview_map_bbox = [{
                    :lat => bbox[0].y,
                    :lon => bbox[0].x}, {
                    :lat => bbox[1].y,
                    :lon => bbox[1].x}]
        else
          @overview_map_bbox = [{
                    :lat => @site.overview_map_bbox_miny,
                    :lon => @site.overview_map_bbox_minx}, {
                    :lat => @site.overview_map_bbox_maxy,
                    :lon => @site.overview_map_bbox_maxx}]

        end

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

  def list_regions1_from_country
    country = Country.find(params[:id])
    regions = country.regions.select("id,name").where(:level => 1).order("name ASC")
    respond_to do |format|
      format.json do
        render :json => regions.map{ |r| {:name => r.name, :id => r.id}}.to_json , :layout => false
      end
    end
  end

  def list_regions2_from_country
    region = Region.find_by_id_and_level(params[:id], 1)
    regions = Region.select("id,name").where(:level => 2,:parent_region_id => region.id).order("name ASC")
    respond_to do |format|
      format.json do
        render :json => regions.map{ |r| {:name => r.name, :id => r.id}}.to_json , :layout => false
      end
    end
  end

  def list_regions3_from_country
    region = Region.find_by_id_and_level(params[:id], 2)
    regions = Region.select("id,name").where(:level => 3,:parent_region_id => region.id).order("name ASC")
    respond_to do |format|
      format.json do
        render :json => regions.map{ |r| {:name => r.name, :id => r.id}}.to_json , :layout => false
      end
    end
  end

end
