module Admin::SitesHelper
  def url(site)
    port = Rails.env == 'development' ? ":#{request.port}" : nil
    "#{site.url}#{port}"
  end
end
