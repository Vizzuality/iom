class PagesController < ApplicationController

  layout 'site_layout'

  def show_about
    unless @page = @site.pages.find_by_title('About')
      raise ActiveRecord::RecordNotFound
    end
    render :action => 'show'
  end

  def show_contact
    unless @page = @site.pages.find_by_title('Contact')
      raise ActiveRecord::RecordNotFound
    end
    render :action => 'show'
  end

end
