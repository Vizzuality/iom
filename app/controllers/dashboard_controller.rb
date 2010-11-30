class DashboardController < ApplicationController

  layout false # TODO: set a new layout

  def index
    @sites = Site.paginate :per_page => 20, :page => params[:page], :order => 'created_at DESC'
  end

end