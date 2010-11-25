class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound,   :with => :render_404
  rescue_from ActionController::RoutingError, :with => :render_404

  before_filter :set_site

  protect_from_forgery

  include AuthenticatedSystem

  protected

    def main_site_host
      case Rails.env
      when 'development'
        'localhost'
      when 'test'
        'example.com'
      when 'production'
        nil
      end
    end

    # Site management
    # ---------------
    #
    # Every environment has a main_site_host which is the host in which the applicacion administrator is
    # running and can have many site_urls, which are the url's associated to each site.
    # Depending on the controller_name, the request should only be handled in the main_site_host.
    #
    def set_site
      if request.host != main_site_host
        unless @site = Site.published.where(:url => request.host).first
          raise ActiveRecord::RecordNotFound
        end
      else
        return true if controller_name == 'sessions'
        if params[:controller] !~ /\Aadmin\/?.+\Z/
          unless @site = Site.draft.where(:id => params[:site_id]).first
            raise ActiveRecord::RecordNotFound
          end
        end
      end
      logger.info "==============================="
      logger.info "== @site: #{@site ? @site.name : 'nil'} =="
      logger.info "==============================="
    end

    def render_404
      render :file => "public/404.html", :status => 404, :layout => false
    end

end
