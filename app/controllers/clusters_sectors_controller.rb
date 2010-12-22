class ClustersSectorsController < ApplicationController

  layout 'site_layout'

  def show
    
    if(request.url.match(/clusters/))
      #CLUSTERS
      @data = Cluster.find(params[:id])
      @projects = @data.projects.where("projects.id IN (#{@site.projects_ids.join(',')})").paginate :per_page => 10, :page => params[:page], :order => 'created_at DESC'
    else
      #SECTORS
      @data = Sector.find(params[:id])
      @projects = @data.projects.where("projects.id IN (#{@site.projects_ids.join(',')})").paginate :per_page => 10, :page => params[:page], :order => 'created_at DESC'
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