class Admin::MediaResourcesController < ApplicationController

  before_filter :login_required
  before_filter :set_element

  def index
    @resource = @element.media_resources.new
  end

  def create
    @resource = @element.media_resources.new(params[:media_resource])
    @resource.element = @element
    if @resource.save
      redirect_to eval("admin_#{@element.class.name.singularize.downcase}_media_resources_path(@element)"), :flash => {:success => 'Resource has been created successfully'}
    else
      render :action => 'index'
    end
  end

  def destroy
    @resource = @element.media_resources.find(params[:id])
    @resource.destroy
    redirect_to eval("admin_#{@element.class.name.singularize.downcase}_media_resources_path(@element)"), :flash => {:success => 'Resource has been destroyed successfully'}
  end

  private

    def set_element
      if params[:project_id]
        @element = @project = Project.find(params[:project_id])
      elsif params[:organization_id]
        @element = @organization = Organization.find(params[:organization_id])
      elsif params[:donor_id]
        @element = @donor = Donor.find(params[:donor_id])
      end
    end

end
