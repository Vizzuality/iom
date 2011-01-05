class PagesController < ApplicationController

  layout 'site_layout'

  def show
    unless @page = @site.pages.find_by_permalink(params[:id])
      raise ActiveRecord::RecordNotFound
    end
  end

end
