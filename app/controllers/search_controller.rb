class SearchController < ApplicationController

  layout 'site_layout'

  def index
    return if params[:q].blank?
    q = "%#{params[:q].sanitize_sql!}%"
    projects = Project.where(["name ilike ? OR description ilike ?", q, q]).where("id IN (#{@site.projects_ids.join(',')})")
    if params[:region_id] || params[:cluster_id]
      if params[:region_id]
        if @region = Region.find(params[:region_id])
          projects = projects.where(["id IN (select project_id from projects_regions where region_id=?)", params[:region_id]])
        else
          render_404 and return
        end
      end
      if params[:cluster_id]
        if @cluster = Cluster.find(params[:cluster_id])
          projects = projects.where(["id IN (select project_id from clusters_projects where cluster_id=?)", params[:cluster_id]])
        else
          render_404 and return
        end
      end
    end
    @clusters = Cluster.find_by_sql("select clusters_projects.cluster_id, count(clusters_projects.cluster_id) as count from clusters_projects where clusters_projects.project_id IN (#{(projects.select("id").all.map(&:id) + [-1]).join(',')}) group by clusters_projects.cluster_id order by count DESC").map do |c_id|
      [Cluster.find(c_id.cluster_id), c_id.count]
    end
    @regions = Region.find_by_sql("select projects_regions.region_id, count(projects_regions.region_id) as count from projects_regions where projects_regions.project_id IN (#{(projects.select("id").all.map(&:id) + [-1]).join(',')})  group by projects_regions.region_id order by count DESC").map do |r_id|
      [Region.find(r_id.region_id), r_id.count]
    end
    @projects = projects.paginate :per_page => 20, :page => params[:page], :order => 'created_at DESC'
  end

end