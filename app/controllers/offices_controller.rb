class OfficesController < ApplicationController

  layout 'site_layout'

  def show
    @office = Office.find(params[:id])
    @donor = @office.donor


    @projects = @office.projects.all

    respond_to do |format|
      format.html
      format.js do
        render :update do |page|
          page << "$('#projects_view_more').html('#{escape_javascript(render(:partial => 'offices/pagination'))}');"
          page << "$('#projects').append('#{escape_javascript(render(:partial => 'offices/projects'))}');"
          page << "IOM.ajax_pagination();"
          page << "resizeColumn();"
        end
      end
    end
  end

end
