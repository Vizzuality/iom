class ApplicationController < ActionController::Base
  class BrowserIsIE6OrLower < Exception; end;

  # rescue_from ActiveRecord::RecordNotFound,   :with => :render_404
  # rescue_from ActionController::RoutingError, :with => :render_404
  rescue_from  BrowserIsIE6OrLower, :with => :old_browser

  before_filter :set_site, :browser_is_ie6_or_lower?

  include AuthenticatedSystem

  cache_sweeper :cluster_sector_sweeper, :organization_sweeper, :page_sweeper, :project_sweeper,
                :region_country_sweeper, :site_sweeper

  def old_browser
    render :file => "/public/old_browser.html.erb", :status => 200, :layout => false
    render :file => "public/404.html.erb", :status => 404, :layout => false
  end

  protected

    # Site management
    # ---------------
    #
    # Every environment has a main_site_host which is the host in which the applicacion administrator is
    # running and can have many site_urls, which are the url's associated to each site.
    # Depending on the controller_name, the request should only be handled in the main_site_host.
    #
    def main_site_host
      case Rails.env
        when 'development'
          # '192.168.1.140'  # to test in ie
          'localhost'
        when 'test'
          'example.com'
        when 'production'
          Settings.main_site_host
      end
    end

    # Filter to set the variable @site, available and used in all the application
    def set_site
      # For development purposes, override all site checks below
      # and loads the specified site
      if params[:force_site_id] || params[:force_site_name]
        @site = Site.find(params[:force_site_id]) if params[:force_site_id]
        @site = Site.where('LOWER(name) = ?', params[:force_site_name].downcase).first if params[:force_site_name]

        self.default_url_options = {:force_site_id => @site.id} if @site
        return
      end

      # If the request host isn't the main_site_host, it should be the host from a site
      if request.host != main_site_host
        unless @site = Site.published.where(:url => request.host).first
          raise ActiveRecord::RecordNotFound
        end
      else
        # Sessions controller doesn't depend on the host
        return true if controller_name == 'sessions'
        # If root path, just go out
        return false if controller_name == 'sites' && params[:site_id].blank?
        # If the controller is not in the namespace /admin,
        # and the host is the main_site_host, it should be a Site
        # in draft mode.
        if params[:controller] !~ /\Aadmin\/?.+\Z/
          unless @site = Site.draft.where(:id => params[:site_id]).first
            raise ActiveRecord::RecordNotFound
          else
            # If a project is a draft, the host of the project is the main_site_host
            # and the site is guessed by the site_id attribute
            self.default_url_options = {:site_id => @site.id}
          end
        end
      end
      if @site && params[:theme_id]
        @site.theme = Theme.find(params[:theme_id])
      end
    end

    def render_404
      render :file => "public/404.html.erb", :status => 404, :layout => false
    end

    def browser_is_ie6_or_lower?
      user_agent = request.user_agent.downcase
      if ie_version = user_agent.match(/MSIE (\d)\.\d;/)
        ie_version = ie_version[1].to_i if ie_version && ie_version.size > 1 && ie_version[1]
        if ie_version && ie_version <= 6
          raise BrowserIsIE6OrLower
        end
      end
    end
end
