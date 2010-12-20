module SitesHelper
  def subtitle(project)
    clusters = project.clusters.map{|c| link_to c.name, cluster_path(c), :title => c.name}.to_sentence
    countries = project.countries.map{|c| link_to c.name, country_path(c), :title => c.name}.to_sentence
    organization = link_to project.primary_organization.name, organization_path(project.primary_organization)
    raw("A #{clusters} project in #{countries} implemented by #{organization}")
  end
end
