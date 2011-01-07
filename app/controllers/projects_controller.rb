class ProjectsController < ApplicationController

  layout 'site_layout'

  def show
    sql = <<-SQL
    select p.id,p.name,p.created_at,p.description, p.primary_organization_id,
     p.implementing_organization, p.partner_organizations, p.cross_cutting_issues, p.start_date,
     p.end_date, p.budget, p.target, p.activities, p.additional_information, p.contact_email,
     p.contact_person, p.contact_phone_number,p.the_geom,
      o.name as primary_organization_name, o.id as primary_organization_id,
         c.name as country_name, c.id as country_id,
         array_to_string(array_agg(distinct sec.name),'|') as sectors_names,
         array_to_string(array_agg(distinct sec.id),'|') as sector_ids,
         array_to_string(array_agg(distinct clus.name),'|') as clusters_names,
         array_to_string(array_agg(distinct clus.id),'|') as cluster_ids
         from organizations o, projects as p
         inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{@site.id}
         inner join countries_projects as cp on ps.project_id=cp.project_id
         inner join countries as c on cp.country_id=c.id
         LEFT JOIN projects_sectors as psec  ON psec.project_id=p.id
         LEFT JOIN sectors as sec             ON sec.id=psec.sector_id
         LEFT JOIN clusters_projects as cpro ON cpro.project_id=p.id
         LEFT JOIN clusters as clus           ON clus.id=cpro.cluster_id
         where p.id=#{params[:id].sanitize_sql!} and o.id=p.primary_organization_id
         GROUP BY p.id,p.name,o.id,o.name,c.name,p.created_at,p.description, p.primary_organization_id,
         p.implementing_organization, p.partner_organizations, p.cross_cutting_issues, p.start_date,
         p.end_date, p.budget, p.target, p.estimated_people_reached, p.contact_person, p.contact_email,
         p.contact_phone_number, p.site_specific_information, p.updated_at, p.created_at, p.activities,
         p.intervention_id, p.additional_information, p.awardee_type, p.date_provided, p.date_updated,
         p.contact_position, p.the_geom, c.id, c.name
SQL

    puts sql
    @project = Project.find_by_sql(sql).first
    raise ActiveRecord::RecordNotFound unless @project

    respond_to do |format|
      format.html do
        #Map data
        sql="select r.id,r.center_lon as lon,r.center_lat as lat,r.name,r.code
        from (projects as p inner join projects_regions as pr on pr.project_id=p.id and p.id=#{@project.id})
        inner join regions as r on pr.region_id=r.id and r.level=#{@site.level_for_region}"

        result=ActiveRecord::Base.connection.execute(sql)
        @map_data=result.to_json
        puts sql
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
        #@chld = areas.join("|")
        @chld = ""
        #@chd  = "t:"+data.join(",")
        @chd = ""
      end
      format.kml
      format.csv do
        send_data @project.to_csv(@site.id),
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=#{@project.name}.csv"
      end
    end
  end

end