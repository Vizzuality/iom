class ClustersController < ApplicationController

  layout 'site_layout'

  def show
    @cluster = @site.cluster
    raise ActiveRecord::RecordNotFound unless @cluster
    @projects = @organization.projects.paginate :per_page => 10, :page => params[:page], :order => 'created_at DESC'
    respond_to do |format|
      format.html
      format.js do
        render :update do |page|
          page << "$('#projects_view_more').remove();"
          page << "$('#projects').append('#{escape_javascript(render(:partial => 'projects'))}');"
          page << "IOM.ajax_pagination();"
        end
      end
    end
  end

end