class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  rescue_from ActionController::RoutingError, :with => :render_404

  protect_from_forgery

  include AuthenticatedSystem

  protected

    def render_404
      render :file => "public/404.html", :status => 404, :layout => false
    end

end
