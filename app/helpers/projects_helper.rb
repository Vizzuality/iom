module ProjectsHelper
  def subtitle(project)
    clusters, countries, organization = ''
    clusters     = clusters_to_sentence(project.clusters) unless @cluster
    countries    = countries_to_sentence(project.countries) unless @country
    organization = organizations_to_sentence(project.primary_organization) unless @organization
    raw("#{clusters} #{countries} #{organization}")
  end

  def clusters_to_sentence(clusters)
    if clusters.count == 1
      "A #{link_to clusters.first.name, cluster_path(clusters.first), :title => clusters.first.name} project"
    else
      "A project from #{pluralize(clusters.count, 'different clusters')}"
    end
  end

  def countries_to_sentence(countries)
    if countries.count == 1
      "in #{link_to countries.first.name, "/country/#{countries.first.id}", :title => countries.first.name}"
    else
      "in #{pluralize(countries.count, 'different countries')}"
    end
  end

  def organizations_to_sentence(organization)
    "implemented by #{link_to organization.name, organization_path(organization)}"
  end
end
