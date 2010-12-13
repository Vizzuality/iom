class ProjectsController < ApplicationController
  respond_to :html, :kml, :csv

  layout 'site_layout'

  def show
    unless @project = @site.projects.select{ |p| p.id == params[:id].to_i}.first
      raise ActiveRecord::RecordNotFound
    end
    respond_with(@project)
  end

end