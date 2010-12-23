class SearchController < ApplicationController

  layout 'site_layout'

  def index
    where  = []
    where_facet = []
    limit = 20
    @current_page   = params[:page] ? params[:page].to_i : 1

    if params[:region_id] || params[:cluster_id]
      if params[:region_id]
        where << "pr.region_id = #{params[:region_id].gsub(/\\/, '\&\&').gsub(/'/, "''")}"
        where_facet << "region_id = #{params[:region_id].gsub(/\\/, '\&\&').gsub(/'/, "''")}"
      end
      if params[:cluster_id]
        where << "p.id IN (select project_id from clusters_projects where cluster_id=#{params[:cluster_id].gsub(/\\/, '\&\&').gsub(/'/, "''")})"
        where_facet << "cp.cluster_id= = #{params[:cluster_id].gsub(/\\/, '\&\&').gsub(/'/, "''")})"
      end
    end

    if params[:q].present?
      q = "%#{params[:q].sanitize_sql!.gsub(/\\/, '\&\&').gsub(/'/, "''")}%"
      where << "p.name ilike '#{q}' OR p.description ilike '#{q}'"
      where_facet << "p.name ilike '#{q}' OR p.description ilike '#{q}'"
    end

    where = where.present? ? "WHERE #{where.join(' AND ')}" : ''

    sql = <<-SQL
      SELECT p.id as project_id,p.name,o.id as organization_id, o.name as organization_name,
      array_to_string(array_agg(distinct r.name),'|') as regions, c.name as country_name
      FROM projects as p
      INNER JOIN organizations as o       ON p.primary_organization_id=o.id
      INNER JOIN projects_sites as ps     ON p.id=ps.project_id and ps.site_id=#{@site.id}
      INNER JOIN projects_regions as pr   ON pr.project_id=p.id
      INNER JOIN regions as r             ON pr.region_id=r.id and r.level=1
      INNER JOIN countries_projects as cp ON cp.project_id=p.id
      INNER JOIN countries as c           ON c.id=cp.country_id
      #{where}
      GROUP BY p.id,p.name,o.id,o.name,c.name,p.created_at
      ORDER BY p.created_at DESC
      LIMIT #{limit} OFFSET #{limit * (@current_page - 1)}
    SQL

    @projects = ActiveRecord::Base.connection.execute(sql)


    respond_to do |format|
      format.html do
        where_facet = where_facet.present? ? "WHERE #{where_facet.join(' AND ')}" : ''
        #cluster Facet
        sql="select c.id,c.name,count(c.id) as count from clusters_projects as cp
                inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=#{@site.id}
                inner join clusters as c on cp.cluster_id=c.id
                inner join projects_regions as pr on ps.project_id=pr.project_id
                inner join projects as p on ps.project_id=p.id
                #{where}
                group by c.id,c.name order by count DESC"

        @clusters = Cluster.find_by_sql(sql).map do |c|
          [c, c.count]
        end

        sql="select r.id,r.name,count(r.id) as count from clusters_projects as cp
                inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=1
                inner join projects_regions as pr on ps.project_id=pr.project_id        
                inner join regions as r on pr.region_id=r.id and r.level=1
                inner join projects as p on ps.project_id=p.id
                #{where}
                group by r.id,r.name order by count DESC"

        @regions = Region.find_by_sql(sql).map do |r|
          [r, r.count]
        end        
      end
      format.js do
        render :update do |page|
          page << "$('#search_results').append('#{escape_javascript(render(:partial => 'search/projects'))}');"
          page << "IOM.ajax_pagination();"
          page << "resizeColumn();"
        end
      end
    end
  end

end