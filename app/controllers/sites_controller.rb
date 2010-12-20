class SitesController < ApplicationController

  layout :sites_layout

  def home
    # If there is no @site, the main home is loaded (see ApplicationController#set_site)
    @sites = Site.paginate :per_page => 20, :page => params[:page], :order => 'created_at DESC' unless @site
  end

  def about

  end

  def sites_layout
    @site ? 'site_layout' : 'root_layout'
  end
  private :sites_layout
end
