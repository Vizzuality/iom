module ProjectsHelper

  def subtitle(project, site)
    clusters_sectors = if site.navigate_by_sector?
      sectors_to_sentence(project)
    else
      clusters_to_sentence(project)
    end
    place        = project_regions_and_countries(project)
    organization = "by #{link_to project['organization_name'], organization_path(project['organization_id'])}"

    case controller_name
    when 'sites'
      raw("#{clusters_sectors} #{place} #{organization}")
    when 'organizations'
      raw("#{clusters_sectors} #{place}")
    when 'clusters_sectors'
      raw("#{place} #{organization}")
    when 'georegion'
      raw("#{clusters_sectors} #{organization}")
    when 'donors'
      raw("#{clusters_sectors} #{place} #{organization}")
    end
  end

  def clusters_to_sentence(project)
    return "" if project['clusters'].nil? || project['cluster_ids'].nil?
    clusters = project['clusters'].split('|').reject{|c| c.blank?}
    clusters_ids = project['cluster_ids'].delete('{}').split(',')
    if clusters.size == 1
      "A #{link_to clusters.first, cluster_path(clusters_ids.first), :title => clusters.first} project"
    else
      "A project from #{pluralize(clusters.size, 'different clusters')}"
    end
  end

  def sectors_to_sentence(project)
    return "" if project['sectors'].nil? || project['sector_ids'].nil?
    sectors = project['sectors'].split('|').reject{|s| s.blank?}
    sectors_ids = project['sector_ids'].delete('{}').split(',')
    if sectors.size == 1
      "A #{link_to sectors.first, sector_path(sectors_ids.first), :title => sectors.first} project"
    else
      "A project from #{pluralize(sectors.size, 'different sectors')}"
    end
  end

  def metainformation(project, site)
    result = ""
    clusters_sectors = []
    if site.navigate_by_sector? && project['sectors'].present?
      project['sectors'].split('|').delete_if{ |e| e.blank? }.each_with_index do |sector_name, i|
        next if sector_name.blank?
        clusters_sectors << link_to(sector_name, sector_path(project['sector_ids'].delete('{}').split(',')[i]))
      end
    elsif site.navigate_by_cluster? && project['clusters'].present?
      project['clusters'].split('|').delete_if{ |e| e.blank? }.each_with_index do |cluster_name, i|
        next if sector_name.blank?
        clusters_sectors << link_to(cluster_name, cluster_path(project['cluster_ids'].delete('{}').split(',')[i]))
      end
    end
    unless clusters_sectors.empty?
      result << " on #{clusters_sectors.to_sentence}"
    end
    result << " by #{link_to(project['organization_name'], organization_path(project['organization_id']))}"
    raw(result)
  end

  def project_regions_and_countries(project)
    return if project['regions'].nil? || project['regions_ids'].nil?
    regions     = project['regions'].split('|').reject{|r| r.blank?}
    regions_ids = project['regions_ids'].delete('{}').split(',')

    if regions.size == 1
      "in #{link_to(regions.first, "/regions/#{regions_ids.first}", :title => regions.first)}"
    else
      "in #{pluralize(regions.size, 'place')}"
    end
  end

  def region_breadcrumb(region)
    result = [region.country.name]
    if region.level == 1
    elsif region.level == 2
      result << Region.find(region.parent_region_id, :select => "id, name, parent_region_id").name
    elsif region.level == 3
      parent = Region.find(region.parent_region_id, :select => "id, name, parent_region_id")
      result << Region.find(parent.parent_region_id, :select => "id, name, parent_region_id").name
      result << parent.name
    end
    result = (result + [region.name]).join(' > ')
    if result.size > 30
      list = result.split(' > ')
      return ([list.first] + ['...'] + [list[-2..-1]]).join(' > ')
    else
      return result
    end
  end

end
