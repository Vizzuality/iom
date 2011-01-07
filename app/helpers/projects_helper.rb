module ProjectsHelper

  def subtitle(project, site)
    # TODO: take into account the sectors
    clusters_sectors = if site.navigate_by_sector?
      sectors_to_sentence(project)
    else
      clusters_to_sentence(project)
    end
    countries    = "in #{project_regions_and_countries(project)}"
    organization = "implemented by #{link_to project['organization_name'], organization_path(project['organization_id'])}"
    raw("#{clusters_sectors} #{countries}")
  end

  def clusters_to_sentence(project)
    return "" if project['clusters'].nil? || project['cluster_ids'].nil?
    clusters = project['clusters'].split('|')
    clusters_ids = project['cluster_ids'].split('|')
    if clusters.size == 1
      "A #{link_to clusters.first, cluster_path(clusters_ids.first), :title => clusters.first} project"
    else
      "A project from #{pluralize(clusters.size, 'different clusters')}"
    end
  end

  def sectors_to_sentence(project)
    return "" if project['sectors'].nil? || project['sector_ids'].nil?
    sectors = project['sectors'].split('|')
    sectors_ids = project['sector_ids'].split('|')
    if sectors.size == 1
      "A #{link_to sectors.first, sector_path(sectors_ids.first), :title => sectors.first} project"
    else
      "A project from #{pluralize(sectors.size, 'different sectors')}"
    end
  end

  def metainformation(project, site)
    result = ""
    clusters_sectors = []
    if site.navigate_by_sector? && project.sectors_names.present?
      project.sectors_names.split('|').each_with_index do |sector_name, i|
        clusters_sectors << link_to(sector_name, sector_path(project.sector_ids[i]))
      end
    elsif site.navigate_by_cluster? && project.clusters_names.present?
      project.clusters_names.split('|').each_with_index do |cluster_name, i|
        clusters_sectors << link_to(cluster_name, cluster_path(project.cluster_ids[i]))
      end
    end
    unless clusters_sectors.empty?
      result << " on #{clusters_sectors.to_sentence}"
    end
    unless project.country_name.blank?
      result << " in #{link_to(project.country_name, location_path(project.country_id.to_a))}"
    end
    result << " by #{link_to(project.primary_organization_name, organization_path(project.primary_organization_id))}"
    raw(result)
  end

  def project_regions_and_countries(project)
    result = []
    # regions =  project['regions'].split('|')
    # regions_ids = project['regions_ids'].split('|')
    # 0.upto(regions.size - 1) do |i|
    #   result << link_to(regions[i], location_path([regions_ids[i]]), :title => regions[i])
    # end
    countries =  project['countries'].split('|')
    countries_ids = project['countries_ids'].split('|')
    0.upto(countries.size - 1) do |i|
      result << link_to(countries[i], location_path([countries_ids[i]]), :title => countries[i])
    end
    result.to_sentence(:last_word_connector => ' and ')
  end

end
