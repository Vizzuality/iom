class SitesController < ApplicationController

  layout 'root_layout'

  def home
    @root_page = @site.blank?
    @home = @root_page ? 'root' : 'site'
    @sites = Site.paginate :per_page => 20, :page => params[:page], :order => 'created_at DESC' if @root_page

    render :layout => "#{@home}_layout"
  end

  def about

  end
end
