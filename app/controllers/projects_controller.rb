class ProjectsController < ApplicationController

  layout 'site_layout'

  def show
    id = if params[:id].sanitize_sql! =~ /^\d+$/
      params[:id].sanitize_sql!
    else
      raise ActiveRecord::RecordNotFound
    end
    sql = "select * from data_denormalization where site_id=#{@site.id} and
                                                    (end_date is null OR end_date > now()) and
                                                    project_id=#{id}"
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
        if @locations.count == 0
          sql="select c.id,c.center_lon as lon,c.center_lat as lat,c.name,c.code
          from (projects as p inner join countries_projects as cp on cp.project_id=p.id and p.id=#{@project.id})
          inner join countries as c on cp.country_id=c.id"
          @locations = ActiveRecord::Base.connection.execute(sql)
        end
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
        send_data Project.to_csv(@site, :project => @project.id),
          :type => 'application/download; application/vnd.ms-excel; text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=#{@project.name}.csv"
      end
    end
  end

end