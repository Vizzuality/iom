class Admin::RegionsController < ApplicationController

  def index
    @regions = Region.where(:country_id => params[:country_id])
    respond_to do |format|
      format.js do
        render :update do |page|
          page << "$('#regions').html('#{escape_javascript(render(:partial => "admin/regions/regions", :layout => false))}');"
        end
      end
    end
  end
end