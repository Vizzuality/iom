class SearchController < ApplicationController

  layout 'site_layout'

  def index
    where  = []
    limit = 20
    @current_page   = params[:page] ? params[:page].to_i : 1

    if params[:region_id] || params[:cluster_id]
      if params[:region_id]
        if @region = Region.find(params[:region_id])
          where << "pr.region_id = #{params[:region_id].gsub(/\\/, '\&\&').gsub(/'/, "''")}"
        else
          render_404 and return
        end
      end
      if params[:cluster_id]
        if @cluster = Cluster.find(params[:cluster_id])
          where << "id IN (select project_id from clusters_projects where cluster_id=#{params[:cluster_id].gsub(/\\/, '\&\&').gsub(/'/, "''")})"
        else
          render_404 and return
        end
      end
    end

    if params[:q].present?
      q = "%#{params[:q].sanitize_sql!.gsub(/\\/, '\&\&').gsub(/'/, "''")}%"
      where << "p.name ilike '#{q}' OR p.description ilike '#{q}'"
    end

    where = where.present? ? "WHERE #{where.join(' AND ')}" : ''

    sql = <<-EOF
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
    EOF

    @projects = ActiveRecord::Base.connection.execute(sql)

    @clusters = Cluster.find_by_sql("select clusters_projects.cluster_id, count(clusters_projects.cluster_id) as count from clusters_projects where clusters_projects.project_id IN (#{(@projects.map{|p| p['project_id']} + [-1]).join(',')}) group by clusters_projects.cluster_id order by count DESC").map do |c_id|
      [Cluster.find(c_id.cluster_id), c_id.count]
    end
    @regions = Region.find_by_sql("select projects_regions.region_id, count(projects_regions.region_id) as count from projects_regions where projects_regions.project_id IN (#{(@projects.map{|p| p['project_id']} + [-1]).join(',')})  group by projects_regions.region_id order by count DESC").map do |r_id|
      [Region.find(r_id.region_id), r_id.count]
    end

    respond_to do |format|
      format.html
      format.js do
        render :update do |page|
          page << "$('#search_results').append('#{escape_javascript(render(:partial => 'search/projects'))}');"
          page << "IOM.ajax_pagination();"
        end
      end
    end
  end

end