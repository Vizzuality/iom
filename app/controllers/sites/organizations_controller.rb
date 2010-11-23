class Sites::OrganizationsController < ApplicationController

  def show
    render :layout => false
    
    @organization = Organization.find(params[:id])
  end

end
