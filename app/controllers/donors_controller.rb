class DonorsController < ApplicationController

  layout 'site_layout'

  def show
    @donor = Donor.find(params[:id])
    @projects = @donor.donated_projects.paginate :per_page => 10, :page => params[:page], :order => 'created_at DESC'
  end

end
