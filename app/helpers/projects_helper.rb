module ProjectsHelper
  def subtitle(project)
    clusters, countries, organization = ''
    clusters     = project.clusters.map{|c| link_to c.name, cluster_path(c), :title => c.name}.to_sentence unless @cluster
    countries    = "in #{project.countries.map{|c| link_to c.name, "/country/#{c.id}", :title => c.name}.to_sentence}" unless @country
    organization = "implemented by #{link_to project.primary_organization.name, organization_path(project.primary_organization)}" unless @organization
    raw("A #{clusters} project #{countries} #{organization}")
  end
end
