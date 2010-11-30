class RegionsController < ApplicationController

  def index
    @regions = Region.where(:country_id => params[:country_id])
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'regions', :partial => 'regions'
        end
      end
    end
  end

end