class Admin::ProjectsController < ApplicationController

  before_filter :login_required

  def index
    if params[:organization_id]
      @organization = Organization.find(params[:organization_id])
      @projects = @organization.projects.paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
      render :template => 'admin/organizations/projects'
    else
      @projects = Project.paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to edit_admin_project_path(@project), :flash => {:success => 'Project has been created successfully'}
    else
      render :action => 'new'
    end
  end

  def donations
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.attributes = params[:project]
    if @project.save
      redirect_to edit_admin_project_path(@project), :flash => {:success => 'Project has been updated successfully'}
    else
      render :action => 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to admin_projects_path, :flash => {:success => 'Project has been deleted successfully'}
  end

end
