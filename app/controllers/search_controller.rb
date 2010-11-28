class SearchController < ApplicationController

  layout 'site_layout'

  def index
    return unless params[:q]
    # TODO: escape to avoid SQL injection
    q = "%#{params[:q]}%"
    projects = Project.where(["name ilike ? OR description ilike ?", q, q])
    if params[:region_id] || params[:cluster_id]
      if params[:region_id]
        projects = projects.where(["id IN (select project_id from projects_regions where region_id=?)", params[:region_id]])
      end
      if params[:cluster_id]
        projects = projects.where(["id IN (select project_id from clusters_projects where cluster_id=?)", params[:cluster_id]])
      end
    end
    @projects = projects.paginate :per_page => 20, :page => params[:page], :order => 'created_at DESC'
  end

end