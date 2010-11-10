class Admin::OrganizationsController < ApplicationController

  before_filter :login_required

  def index
    @organizations = Organization.paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
      redirect_to edit_admin_organization_path(@organization), :flash => {:success => 'Organization has been created successfully'}
    else
      render :action => 'new'
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    @organization.attributes = params[:organization]
    if @organization.save
      redirect_to edit_admin_organization_path(@organization), :flash => {:success => 'Organization has been updated successfully'}
    else
      render :action => 'edit'
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to admin_organizations_path, :flash => {:success => 'Organization has been deleted successfully'}
  end

end
