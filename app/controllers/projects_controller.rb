class ProjectsController < ApplicationController

  layout 'site_layout'

  def show
    @project = @site.projects.select{ |p| p.id == params[:id].to_i}.first
  end

end