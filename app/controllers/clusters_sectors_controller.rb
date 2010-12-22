class ClustersSectorsController < ApplicationController

  layout 'site_layout'

  def show
    if(request.url.match(/clusters/))
      # clusters
      render_404 and return unless @site.navigate_by_cluster?
      @data = Cluster.find(params[:id])
      @projects = Project.custom_find(@site, :cluster => @data.name, :per_page => 10, :page => params[:page], :order => 'created_at DESC')
    else
      # sectors
      render_404 and return unless @site.navigate_by_sector?
      @data = Sector.find(params[:id])
      @projects = Project.custom_find(@site, :sector => @data.name, :per_page => 10, :page => params[:page], :order => 'created_at DESC')
    end

    respond_to do |format|
      format.html
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