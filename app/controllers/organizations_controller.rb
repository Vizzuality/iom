class OrganizationsController < ApplicationController

  layout 'site_layout'

  def index
    @organizations = @site.organizations
  end

  def show
    @organization = @site.organizations.select{ |org| org.id == params[:id].to_i }.first
  end

end