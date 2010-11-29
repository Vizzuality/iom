class ProjectsController < ApplicationController

  layout 'site_layout'

  def show
    unless @project = @site.projects.select{ |p| p.id == params[:id].to_i}.first
      raise ActiveRecord::RecordNotFound
    end
  end

end