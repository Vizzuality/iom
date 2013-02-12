class Admin::OrganizationsController < ApplicationController

  before_filter :login_required

  def index
    redirect_to edit_admin_organization_path(current_user.organization) and return unless current_user.admin?

    organizations = if params[:q]
      q = "%#{params[:q].sanitize_sql!}%"
      Organization.where(["name ilike ? OR description ilike ?", q, q])
    else
      Organization
    end
    @organizations = organizations.order('name asc').paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
      flash[:notice] = 'Organization created succesfully.'
      redirect_to edit_admin_organization_path(@organization), :flash => {:success => 'Organization has been created successfully'}
    else
      render :action => 'new'
    end
  end

  def specific_information
    @organization = Organization.find(params[:id])
    @site = Site.find(params[:site_id])
    @organization.attributes = @organization.attributes_for_site(@site)
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    if params[:organization][:projects_file].present?
      projects_with_errors = @organization.sync_projects(params[:organization].delete(:projects_file))

      if projects_with_errors.present?
        send_data projects_with_errors,
          :type        => 'application/vnd.ms-excel',
          :disposition => "attachment; filename=#{@organization.name}_projects.xls"
      end
      return
    end
    if params[:site_id]
      if @site = Site.find(params[:site_id])
        @organization.attributes_for_site = {:organization_values => params[:organization], :site_id => params[:site_id]}
      end
    else
      @organization.attributes = params[:organization]
      @organization.user.blocked = params[:organization][:user_attributes][:blocked] if @organization.user && params[:organization][:user_attributes] && params[:organization][:user_attributes][:blocked]
    end
    @organization.updated_by = current_user
    if @organization.save
      flash[:notice] = 'Organization updated succesfully.'
      if params[:site_id]
        redirect_to organization_site_specific_information_admin_organization_path(@organization, @site), :flash => {:success => 'Organization has been updated successfully'}
      else
        redirect_to edit_admin_organization_path(@organization), :flash => {:success => 'Organization has been updated successfully'}
      end
    else
      flash.now[:error] = @organization.errors.full_messages
      render :action => 'edit'
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to admin_organizations_path, :flash => {:success => 'Organization has been deleted successfully'}
  end

  def destroy_logo
    @organization = Organization.find(params[:id])
    @organization.logo.clear
    @organization.save
    respond_to do |format|
      format.html do
        redirect_to edit_admin_organization_path(@organization), :flash => {:success => 'Organization logo has been removed successfully'}
      end
    end
  end

end
