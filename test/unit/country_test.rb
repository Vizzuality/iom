require File.expand_path('../../test_helper', __FILE__)

class CountryTest < ActiveSupport::TestCase

  test "Updates wikipedia description on save" do
    wikipedia_url = 'http://en.wikipedia.org/wiki/Dominican_republic'
    dominican_republic = Country.create(:name => 'Dominican Republic', :wiki_url => wikipedia_url)
    assert dominican_republic.wiki_description.present?
    assert_match 'The Dominican Republic (i/dəˌmɪnɪkən rɪˈpʌblɪk/; Spanish: República Dominicana,', dominican_republic.wiki_description
  end

  test "projects_clusters of a site" do
    spain    = create_country :name => 'Spain'
    germany  = create_country :name => 'Germany'

    c1 = create_cluster
    c2 = create_cluster
    c3 = create_cluster

    organization1 = create_organization
    organization2 = create_organization

    p1 = create_project :name => 'P1', :primary_organization => organization1
    p2 = create_project :name => 'P2', :primary_organization => organization2
    p3 = create_project :name => 'P3', :primary_organization => organization1

    p1.clusters << c1
    p2.clusters << c2
    p3.clusters << c3
    p3.clusters << c1

    p1.countries << spain
    p2.countries << germany
    p3.countries << spain

    site1 = create_site :name => 'Food for Haiti 1', :project_context_organization_id => organization1.id, :project_context_cluster_id => nil, :url => 'http://site1.com'
    site2 = create_site :name => 'Food for Haiti 2', :project_context_organization_id => organization2.id, :project_context_cluster_id => nil, :url => 'http://site2.com'

    site1.reload
    site2.reload
    p1.reload
    p2.reload
    p3.reload

    assert_equal 2, spain.projects_clusters(site1).size
    assert spain.projects_clusters(site1).flatten.include?(c1)
    assert spain.projects_clusters(site1).flatten.include?(c3)

    assert_equal 0, spain.projects_clusters(site2).size

    assert_equal 0, germany.projects_clusters(site1).size
    assert_equal 1, germany.projects_clusters(site2).size
    assert germany.projects_clusters(site2).flatten.include?(p2)
  end

end
