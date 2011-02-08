class ProjectsController < ApplicationController

  layout 'site_layout'

  def show
    id = if params[:id].sanitize_sql! =~ /^\d+$/
      params[:id].sanitize_sql!
    else
      raise ActiveRecord::RecordNotFound
    end
    sql = "select * from data_denormalization where site_id=#{@site.id} and
                                                    is_active=true and
                                                    project_id=#{params[:id].sanitize_sql!}"
    @raw_project = Project.find_by_sql(sql).first
    raise ActiveRecord::RecordNotFound unless @raw_project
    @project = Project.find(@raw_project['project_id'])

    respond_to do |format|
      format.html do
        #Map data
        sql="select r.id,r.center_lon as lon,r.center_lat as lat,r.name,r.code,r.country_id
        from (projects as p inner join projects_regions as pr on pr.project_id=p.id and p.id=#{@project.id})
        inner join regions as r on pr.region_id=r.id and r.level=#{@site.level_for_region}"

        @locations = ActiveRecord::Base.connection.execute(sql)
        @map_data  = @locations.to_json

        @overview_map_chco = @site.theme.data[:overview_map_chco]
        @overview_map_chf = @site.theme.data[:overview_map_chf]
        @overview_map_marker_source = @site.theme.data[:overview_map_marker_source]

        areas= []
        data = []
        @map_data_max_count=0
        @locations.each do |c|
          areas << c["code"]
          data  << 1
        end
        #@chld = areas.join("|")
        @chld = ""
        #@chd  = "t:"+data.join(",")
        @chd = ""
      end
      format.kml
      format.csv do
        send_data @project.to_csv(@site.id),
          :type => 'application/vnd.ms-excel; text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=#{@project.name}.csv"
      end
    end
  end

end