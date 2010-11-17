class Admin::PartnersController < ApplicationController

  before_filter :login_required

  def create
    @site = Site.find(params[:site_id])
    @partner = @site.partners.new
    @partner.attributes = params[:partner]
    if @partner.save
      redirect_to customization_admin_site_path(@site), :flash => {:success => 'Partner has been created successfully'}
    else
      render :template => 'admin/sites/edit'
    end
  end

  def destroy
    @site = Site.find(params[:site_id])
    @partner = @site.partners.find(params[:id])
    @partner.destroy
    redirect_to customization_admin_site_path(@site), :flash => {:success => 'Partner has been deleted successfully'}
  end

end
