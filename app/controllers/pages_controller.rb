class PagesController < ApplicationController

  layout 'site_layout'

  def show
    unless @page = Page.find_by_permalink(params[:id])
      raise ActiveRecord::RecordNotFound
    end
  end

end
