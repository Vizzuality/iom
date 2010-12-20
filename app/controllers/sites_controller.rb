class SitesController < ApplicationController

  layout :sites_layout

  def home
    @sites = Site.paginate :per_page => 20, :page => params[:page], :order => 'created_at DESC' unless @sites
  end

  def about

  end

  def sites_layout
    @site ? 'site_layout' : 'root_layout'
  end
  private :sites_layout
end
