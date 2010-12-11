class DonorsController < ApplicationController

  layout 'site_layout'

  def show
    @donor = Donor.find(params[:id])
    @donor.attributes = @donor.attributes_for_site(@site)
    
    @projects = @donor.donated_projects.where("projects.id IN (#{@site.projects_ids.join(',')})").paginate :per_page => 10, :page => params[:page], :order => 'created_at DESC'
  end

end
