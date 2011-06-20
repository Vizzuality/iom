class Admin::OrganizationsController < ApplicationController

  before_filter :login_required

  def index
    organizations = if params[:q]
      q = "%#{params[:q].sanitize_sql!}%"
      Organization.where(["name ilike ? OR description ilike ?", q, q])
    else
      Organization
    end
    @organizations = organizations.paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
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
        ordered_header = projects_with_errors.slice!(0)
        results_in_csv = FasterCSV.generate(:col_sep => ';') do |csv|
          csv << ordered_header
          projects_with_errors.each do |result|
            line = []
            ordered_header.each do |field_name|
              v = result[field_name]
              line << (v.nil?? '' : v)
            end
            csv << line
          end
        end

        send_data results_in_csv,
          :type => 'application/download; application/vnd.ms-excel; text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=#{@organization.name}_projects.csv"
        return
      end
    end
    if params[:site_id]
      if @site = Site.find(params[:site_id])
        @organization.attributes_for_site = {:organization_values => params[:organization], :site_id => params[:site_id]}
      end
    else
      @organization.attributes = params[:organization]
    end
    if @organization.save
      if params[:site_id]
        redirect_to organization_site_specific_information_admin_organization_path(@organization, @site), :flash => {:success => 'Organization has been updated successfully'}
      else
        redirect_to edit_admin_organization_path(@organization), :flash => {:success => 'Organization has been updated successfully'}
      end
    else
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
