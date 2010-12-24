class DonorsController < ApplicationController

  layout 'site_layout'

  def show
    @donor = Donor.find(params[:id])
    @donor.attributes = @donor.attributes_for_site(@site)

    @projects = Project.custom_find(@site, :donor_id => @donor.id, :per_page => 10, :page => params[:page], :order => 'created_at DESC')

    respond_to do |format|
      format.html
      format.js do
        render :update do |page|
          page << "$('#projects_view_more').remove();"
          page << "$('#projects').append('#{escape_javascript(render(:partial => 'donors/projects'))}');"
          page << "IOM.ajax_pagination();"
          page << "resizeColumn();"
        end
      end
    end
  end

end
