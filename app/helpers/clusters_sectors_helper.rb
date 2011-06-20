module ClustersSectorsHelper
  def clusters_sectors_projects_list_subtitle
    if @filter_by_location
      truncate((pluralize(@cluster_sector_projects_count, "#{@data.name} PROJECT", "#{@data.name} PROJECTS") + " in #{@location_name}").strip, :length => 60)
    else
       location = if @site.navigate_by_country?
         pluralize(@data.total_countries(@site), 'country', 'countries')
       else
         pluralize(@data.total_regions(@site), @site.word_for_regions.singularize, @site.word_for_regions)
       end
       truncate(("#{pluralize(@cluster_sector_projects_count, 'PROJECT', 'PROJECTS')}  in #{location}").strip, :length => 60)
    end
  end

end