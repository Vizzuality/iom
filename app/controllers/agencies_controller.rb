class AgenciesController < ApplicationController

  layout 'site_layout'

  def show
    @agency = Agency.find(params[:id])
    @donor = @agency.donor


    @projects = @agency.projects.all

    respond_to do |format|
      format.html
      format.js do
        render :update do |page|
          page << "$('#projects_view_more').html('#{escape_javascript(render(:partial => 'agencies/pagination'))}');"
          page << "$('#projects').append('#{escape_javascript(render(:partial => 'agencies/projects'))}');"
          page << "IOM.ajax_pagination();"
          page << "resizeColumn();"
        end
      end
    end
  end

end
