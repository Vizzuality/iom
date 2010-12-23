class ProjectsController < ApplicationController

  layout 'site_layout'

  def show
    unless @project = @site.projects.select{ |p| p.id == params[:id].to_i}.first
      raise ActiveRecord::RecordNotFound
    end

    #Map data
    sql="select r.id,x(ST_Centroid(r.the_geom)) as lon,y(ST_Centroid(r.the_geom)) as lat,r.name,r.code
    from (projects as p inner join projects_regions as pr on pr.project_id=p.id and p.id=1)
    inner join regions as r on pr.region_id=r.id and r.level=1"

    result = ActiveRecord::Base.connection.execute(sql)
    @map_data=result.to_json
    @overview_map_bbox = [{
              :lat => @site.overview_map_bbox_miny,
              :lon => @site.overview_map_bbox_minx}, {
              :lat => @site.overview_map_bbox_maxy,
              :lon => @site.overview_map_bbox_maxx}]
    @overview_map_chco = @site.theme.data[:overview_map_chco]
    @overview_map_chf = @site.theme.data[:overview_map_chf]
    @overview_map_marker_source = @site.theme.data[:overview_map_marker_source]

    areas= []
    data = []
    @map_data_max_count=0
    result.each do |c|
      areas << c["code"]
      data  << 1
    end
    @chld = areas.join("|")
    @chd  = "t:"+data.join(",")

    respond_to do |format|
      format.html
      format.kml
      format.csv do
        send_data @project.to_csv(@site.id),
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=#{@project.name}.csv"
      end
    end
  end

end