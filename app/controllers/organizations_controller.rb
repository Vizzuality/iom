class OrganizationsController < ApplicationController

  layout 'site_layout'

  def index
    @organizations = @site.organizations
  end

  def show
    unless @organization = @site.organizations.select{ |org| org.id == params[:id].to_i }.first
      raise ActiveRecord::RecordNotFound
    end
    @organization.attributes = @organization.attributes_for_site(@site)

    @projects = Project.custom_find @site, :organization => @organization.id,
                                           :per_page => 10,
                                           :page => params[:page],
                                           :order => 'created_at DESC',
                                           :start_in_page => params[:start_in_page]
    respond_to do |format|
      format.html do
        #Map data
        if(@site.geographic_context_country_id)
          sql="select r.id,count(ps.project_id) as count,r.name,r.center_lon as lon,r.center_lat as lat,r.name,'/regions/'||r.id as url,r.code
                from ((((projects as p inner join organizations as o on o.id=p.primary_organization_id and
                o.id=#{params[:id].gsub(/\\/, '\&\&').gsub(/'/, "''")})
                inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{@site.id})
                inner join projects as prj on ps.project_id=prj.id and (prj.end_date is null OR prj.end_date > now())
                inner join projects_regions as pr on pr.project_id=p.id)
                inner join regions as r on pr.region_id=r.id and r.level=#{@site.level_for_region})
                group by r.id,r.name,lon,lat,r.name,url,r.code"
        else
          sql="select c.id,count(ps.project_id) as count,c.name,r.center_lon as lon,r.center_lat as lat,c.name,'/location/'||c.id as url,c.iso2_code as code
                from ((((projects as p inner join organizations as o on o.id=p.primary_organization_id and o.id=
                #{params[:id].gsub(/\\/, '\&\&').gsub(/'/, "''")})
                inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{@site.id}) inner join projects_regions as pr on pr.project_id=p.id)
                inner join projects as prj on ps.project_id=prj.id and (prj.end_date is null OR prj.end_date > now())
                inner join countries_projects as cp on cp.project_id=ps.project_id)
                inner join countries as c on cp.country_id=c.id
                group by c.id,c.name,lon,lat,c.name,url,c.iso2_code"
        end

        result=ActiveRecord::Base.connection.execute(sql)
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
          data  << c["count"]
          if(@map_data_max_count < c["count"].to_i)
            @map_data_max_count=c["count"].to_i
          end
        end
        #@chld = areas.join("|")
        @chld = ""
        #@chd  = "t:"+data.join(",")
        @chd = ""
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