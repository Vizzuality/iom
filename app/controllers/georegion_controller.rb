class GeoregionController < ApplicationController

  layout 'site_layout'

  def show
    if(request.url.match(/countries/))
      @area = Country.find(params[:id])
      @area_parent = "America"
    else
      @area = Region.find(params[:id])
      @area_parent = @area.country.try(:name)
    end
    
    @projects = @area.projects.site(@site).where("id IN (#{@site.projects_ids.join(',')})").paginate :per_page => 10, :page => params[:page], :order => 'created_at DESC'
    

    respond_to do |format|
      format.html {render :show}
      format.js do
        render :update do |page|
          page << "$('#projects_view_more').remove();"
          page << "$('#projects').append('#{escape_javascript(render(:partial => 'projects/projects'))}');"
          page << "IOM.ajax_pagination();"
        end
      end
    end
    
  end

end