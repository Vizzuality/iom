module Admin::PagesHelper

  def home_or_site
    return @site.name if @site.present?
    'General Home'
  end

  def page_path_for_home_or_site(page)
    return admin_site_page_path(@site, page) if @site.present?
    admin_page_path(page)
  end

  def pages_path_for_home_or_site(options = {})
    return admin_site_pages_path(@site, options) if @site.present?
    admin_pages_path(options)
  end

  def new_page_path_for_home_or_site
    return new_admin_site_page_path(@site) if @site.present?
    new_admin_page_path
  end

  def edit_page_path_for_home_or_site(page, options = {})
    return edit_admin_site_page_path(@site, page, options) if @site.present?
    edit_admin_page_path(page, options)
  end

  def page_resources
    return [:admin, @site, @page || @site.pages.new] if @site.present?
    [:admin, @page || MainPage.new]
  end

  def create_or_update_pages_path_for_home_or_site
    return page_path_for_home_or_site(@page) if @page && @page.persisted?
    pages_path_for_home_or_site
  end

end
