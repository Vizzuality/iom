module GeoregionHelper
  def georegion_projects_list_subtitle
    if @filter_by_category
      pluralize(@georegion_projects_count, "#{@category_name} PROJECT", "#{@category_name} PROJECTS") + " in #{@area.name.upcase}"
    else
      "#{pluralize(@georegion_projects_count, 'PROJECT', 'PROJECTS')} IN #{@area.name.upcase}"
    end
  end

end