module ProjectsHelper
  def subtitle(project)
    clusters     = clusters_to_sentence(project)
    countries    = "in #{link_to project['countries'], country_path(project['countries_ids']), :title => project['countries']}"
    organization = "implemented by #{link_to project['organization_name'], organization_path(project['organization_id'])}"
    raw("#{clusters} #{countries} #{organization}")
  end

  def clusters_to_sentence(project)
    return "" if project['clusters'].nil? || project['cluster_ids'].nil?
    clusters = project['clusters']
    clusters_ids = project['cluster_ids']
    if clusters.size == 1
      "A #{link_to clusters.first, cluster_path(clusters_ids.first), :title => clusters.first} project"
    else
      "A project from #{pluralize(clusters.size, 'different clusters')}"
    end
  end

end
