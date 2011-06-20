module GeoregionHelper
  def georegion_projects_list_subtitle
    if @filter_by_category
      truncate((pluralize(@georegion_projects_count, "#{@category_name} PROJECT", "#{@category_name} PROJECTS") + " in #{@area.name.upcase}").strip, :length => 60)
    else
      truncate("#{pluralize(@georegion_projects_count, 'PROJECT', 'PROJECTS')} IN #{@area.name.upcase}".strip, :length => 60)
    end
  end

end