module SitesHelper
  def site_project_count
    output = "#{pluralize(@site.total_projects, 'active project', 'active projects')} in "

    if @site.navigate_by_country?
      output << pluralize(@site.total_countries, 'country', 'countries').strip
    else
      output << pluralize(@site.total_regions, @site.word_for_regions.singularize, @site.word_for_regions).strip
    end
    truncate(output.strip, :length => 60)
  end
end
