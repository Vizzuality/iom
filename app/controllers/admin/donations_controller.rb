class Admin::DonationsController < ApplicationController

  before_filter :login_required

  def create
    @project = Project.find(params[:project_id])
    @donation = @project.donations.new(params[:donation])
    if @donation.save
      redirect_to donations_admin_project_path(@project), :flash => {:success => 'Donation has been created successfully'}
    else
      render :action => 'new'
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @donation = @project.donations.find(params[:id])
    @donation.destroy
    redirect_to donations_admin_project_path(@project), :flash => {:success => 'Donation has been deleted successfully'}
  end

end
