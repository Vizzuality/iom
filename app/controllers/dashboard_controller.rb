class DashboardController < ApplicationController

  layout 'sites_layout' 

  def index
    @sites = Site.paginate :per_page => 20, :page => params[:page], :order => 'created_at DESC'
  end

end