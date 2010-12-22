class DonorsController < ApplicationController

  layout 'site_layout'

  def show
    @donor = Donor.find(params[:id])
    @donor.attributes = @donor.attributes_for_site(@site)

    @projects = Project.custom_find(@site, :donor_id => @donor.id, :per_page => 10, :page => params[:page], :order => 'created_at DESC')
  end

end
