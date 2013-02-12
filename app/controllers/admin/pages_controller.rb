class Admin::PagesController < ApplicationController
  include Admin::PagesHelper

  before_filter :login_required, :set_site

  def index
    @pages = pages.highlighted.paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
    @all_pages = @pages
  end

  def new
    @page = pages.new
    @all_pages = pages.highlighted
  end

  def create
    @pages = pages.highlighted
    @page = pages.new(params[:page])
    if @page.save
      flash[:notice] = 'Page created succesfully.'
      redirect_to edit_page_path_for_home_or_site(@page), :flash => {:success => 'Page has been created successfully'}
    else
      render :action => 'new'
    end
  end

  def edit
    @all_pages = pages.highlighted
    @page = pages.from_param(params[:id])
  end

  def update
    @page = pages.find_by_permalink(params[:id])

    if @page.update_attributes(params[:page])
      flash[:notice] = 'Page updated succesfully.'
      redirect_to edit_page_path_for_home_or_site(@page), :flash => {:success => 'Page has been updated successfully'}
    else
      render :action => 'edit'
    end
  end

  def destroy
    @page = pages.from_param(params[:id])
    @page.destroy
    redirect_to pages_path_for_home_or_site, :flash => {:success => 'Page has been deleted successfully'}
  end

  private
  def pages
    pages = if @site.present?
              @site.pages
            else
              MainPage
            end
  end

  protected

    def set_site
      @site = Site.find(params[:site_id]) if params[:site_id]
    end

end
