class OrganizationsController < ApplicationController

  layout 'site_layout'

  def index
    @organizations = @site.organizations
  end

  def show
    @organization = @site.organizations.select{ |org| org.id == params[:id].to_i }.first
    raise ActiveRecord::RecordNotFound unless @organization
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