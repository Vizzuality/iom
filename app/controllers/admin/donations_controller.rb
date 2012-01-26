class Admin::DonationsController < Admin::AdminController

  before_filter :login_required

  def create
    @project = Project.find(params[:project_id])
    donor = Donor.where(:id => params[:donation][:donor_id]).first
    @donation = @project.donations.new(params[:donation].slice!(:donor_id))
    @donation.donor = donor if donor.present?
    if @donation.save
      redirect_to donations_admin_project_path(@project), :flash => {:success => 'Donation has been created successfully'}
    else
      render :template => 'admin/projects/donations'
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @donation = @project.donations.find(params[:id])
    @donation.destroy
    redirect_to donations_admin_project_path(@project), :flash => {:success => 'Donation has been deleted successfully'}
  end

end
