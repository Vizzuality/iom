class GeoregionController < ApplicationController

  layout 'site_layout'

  def show
    if(request.url.match(/countries/))
      puts "COUNTRIES"
      
    else
      puts "REGIONS"
      
    end
    
    
  end

  def region
    @region = Region.find(params[:id])
    @projects = @region.projects.site(@site).where("id IN (#{@site.projects_ids.join(',')})").paginate :per_page => 10, :page => params[:page], :order => 'created_at DESC'
    
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
  
  
  def country
    @country = Country.find(params[:id])
    @projects = @country.projects.site(@site).where("projects.id IN (#{@site.projects_ids.join(',')})").paginate :per_page => 10, :page => params[:page], :order => 'created_at DESC'
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
    
    render :show
  end

end