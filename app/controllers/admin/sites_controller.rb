class Admin::SitesController < ApplicationController

  before_filter :login_required

  def index
    @sites = Site.paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(params[:site])
    if @site.save
      redirect_to customization_admin_site_path(@site), :flash => {:success => 'Site has been created successfully'}
    else
      render :action => 'new'
    end
  end

  def projects
    @site = Site.find(params[:id])
  end

  def edit
    @site = Site.find(params[:id])
  end

  def customization
    @site = Site.find(params[:id])
    render :action => 'edit'
  end

  def update
    @site = Site.find(params[:id])
    @site.attributes = params[:site]
    if @site.save
      redirect_to edit_admin_site_path(@site), :flash => {:success => 'Site has been updated successfully'}
    else
      render :action => 'edit'
    end
  end

  def toggle_status
    @site = Site.find(params[:id])
    @site.status = !@site.status
    if @site.save
      respond_to do |format|
        format.html do
          redirect_to edit_admin_site_path(@site), :flash => {:success => 'Site has been updated successfully'}
        end
        format.js do
          render :update do |page|
            page << "$('#site_#{@site.id}').html('#{escape_javascript(render(:inline => "<%= link_to((@site.published? ? 'Published' : 'Not published'), toggle_status_admin_site_path(@site), :method => :post,:remote => true,:class => (@site.published? ? 'published' : 'not_published')) %>"))}');"
          end
        end
      end
    end
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    redirect_to admin_sites_path, :flash => {:success => 'Site has been deleted successfully'}
  end

end
