require File.expand_path('../../test_helper', __FILE__)

class CountryTest < ActiveSupport::TestCase

  test "Updates wikipedia description on save" do
    wikipedia_url = 'http://en.wikipedia.org/wiki/Dominican_republic'
    dominican_republic = Country.create(:name => 'Dominican Republic', :wiki_url => wikipedia_url)
    assert dominican_republic.wiki_description.present?
    assert_match 'The Dominican Republic (i/dəˌmɪnɪkən rɪˈpʌblɪk/; Spanish: República Dominicana,', dominican_republic.wiki_description
  end

  # should list the clusters of the projects in one site that belongs to a given country
  test "projects_clusters_sectors of a site navigated by clusters" do
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

    assert_equal 2, spain.projects_clusters_sectors(site1).size
    assert spain.projects_clusters_sectors(site1).flatten.include?(c1)
    assert spain.projects_clusters_sectors(site1).flatten.include?(c3)

    assert_equal 0, spain.projects_clusters_sectors(site2).size

    assert_equal 0, germany.projects_clusters_sectors(site1).size
    assert_equal 1, germany.projects_clusters_sectors(site2).size

    assert germany.projects_clusters_sectors(site2).flatten.include?(c2)

    p2.update_attribute(:end_date, Date.today.yesterday)
    p2.reload
    site2.reload

    assert_equal 0, germany.projects_clusters_sectors(site2).size
  end

  test "projects_clusters_sectors of a site navigated by sectors" do
    spain    = create_country :name => 'Spain'
    germany  = create_country :name => 'Germany'

    s1 = create_sector
    s2 = create_sector
    s3 = create_sector

    organization1 = create_organization
    organization2 = create_organization

    p1 = create_project :name => 'P1', :primary_organization => organization1
    p2 = create_project :name => 'P2', :primary_organization => organization2
    p3 = create_project :name => 'P3', :primary_organization => organization1

    p1.sectors << s1
    p2.sectors << s2
    p3.sectors << s3
    p3.sectors << s1

    p1.countries << spain
    p2.countries << germany
    p3.countries << spain

    site1 = create_site :name => 'Food for Haiti 1', :project_context_organization_id => organization1.id,
                        :project_context_cluster_id => nil, :url => 'http://site1.com',
                        :project_classification => 1
    site2 = create_site :name => 'Food for Haiti 2', :project_context_organization_id => organization2.id,
                        :project_context_cluster_id => nil, :url => 'http://site2.com',
                        :project_classification => 1

    site1.reload
    site2.reload
    p1.reload
    p2.reload
    p3.reload

    assert_equal 2, spain.projects_clusters_sectors(site1).size
    assert spain.projects_clusters_sectors(site1).flatten.include?(s1)
    assert spain.projects_clusters_sectors(site1).flatten.include?(s3)

    assert_equal 0, spain.projects_clusters_sectors(site2).size

    assert_equal 0, germany.projects_clusters_sectors(site1).size
    assert_equal 1, germany.projects_clusters_sectors(site2).size

    assert germany.projects_clusters_sectors(site2).flatten.include?(s2)

    p2.update_attribute(:end_date, Date.today.yesterday)
    p2.reload
    site2.reload

    assert_equal 0, germany.projects_clusters_sectors(site2).size
  end

  # should list the regions of the projects in one site that belongs to a given country
  test "regions_projects of a site" do
    spain    = create_country :name => 'Spain'
    germany  = create_country :name => 'Germany'

    valencia = create_region :name => 'Valencia', :country => spain, :level => 1
    madrid   = create_region :name => 'Madrid', :country => spain,   :level => 1
    lerida   = create_region :name => 'Lerida', :country => spain,   :level => 2

    berlin   = create_region :name => 'Berlin', :country => germany, :level => 1
    dresden  = create_region :name => 'Berlin', :country => germany, :level => 2

    organization1 = create_organization
    organization2 = create_organization

    p1 = create_project :name => 'P1', :primary_organization => organization1
    p2 = create_project :name => 'P2', :primary_organization => organization2
    p3 = create_project :name => 'P3', :primary_organization => organization1

    p1.regions << valencia
    p1.regions << madrid
    p2.regions << berlin
    p2.regions << dresden
    p3.regions << valencia

    site1 = create_site :name => 'Food for Haiti 1', :project_context_organization_id => organization1.id, :project_context_cluster_id => nil, :url => 'http://site1.com'
    site2 = create_site :name => 'Food for Haiti 2', :project_context_organization_id => organization2.id, :project_context_cluster_id => nil, :url => 'http://site2.com'

    site1.reload
    site2.reload
    p1.reload
    p2.reload
    p3.reload

    assert p1.countries.include?(spain)
    assert p2.countries.include?(germany)
    assert p3.countries.include?(spain)

    assert_equal 2, spain.regions_projects(site1).size
    assert spain.regions_projects(site1).flatten.include?(madrid)
    assert spain.regions_projects(site1).flatten.include?(valencia)

    assert_equal 0, spain.regions_projects(site2).size

    assert_equal 0, germany.regions_projects(site1).size

    assert_equal 1, germany.regions_projects(site2).size
    assert germany.regions_projects(site2).flatten.include?(berlin)

    p2.update_attribute(:end_date, Date.today.yesterday)
    p2.reload
    site2.reload
    assert_equal 0, germany.regions_projects(site2).size
  end

  test "donors and donors count of a site" do
    spain    = create_country :name => 'Spain'
    germany  = create_country :name => 'Germany'
    france   = create_country :name => 'France'

    organization1 = create_organization
    organization2 = create_organization

    p1 = create_project :name => 'P1', :primary_organization => organization1
    p2 = create_project :name => 'P2', :primary_organization => organization2
    p3 = create_project :name => 'P3', :primary_organization => organization1

    p1.countries << spain
    p2.countries << germany
    p3.countries << spain
    p1.countries << france
    p2.countries << france

    donor1 = create_donor
    donor2 = create_donor
    donor3 = create_donor

    p1.donations.create! :donor => donor1, :amount => 100
    p2.donations.create! :donor => donor2, :amount => 100
    p3.donations.create! :donor => donor3, :amount => 100

    site1 = create_site :name => 'Food for Haiti 1', :project_context_organization_id => organization1.id, :project_context_cluster_id => nil, :url => 'http://site1.com'
    site2 = create_site :name => 'Food for Haiti 2', :project_context_organization_id => organization2.id, :project_context_cluster_id => nil, :url => 'http://site2.com'

    site1.reload
    site2.reload
    p1.reload
    p2.reload
    p3.reload

    assert_equal 2, spain.donors_count(site1)
    assert_equal 0, spain.donors_count(site2)
    assert_equal 0, germany.donors_count(site1)
    assert_equal 1, germany.donors_count(site2)
    assert_equal 1, france.donors_count(site1)
    assert_equal 1, france.donors_count(site2)

    assert spain.donors(site1).include?(donor1)
    assert spain.donors(site1).include?(donor3)
    assert germany.donors(site2).include?(donor2)
    assert france.donors(site1).include?(donor1)
    assert france.donors(site2).include?(donor2)
  end

  test "projects_count of a site" do
    spain    = create_country :name => 'Spain'
    germany  = create_country :name => 'Germany'
    france   = create_country :name => 'France'

    organization1 = create_organization
    organization2 = create_organization

    p1 = create_project :name => 'P1', :primary_organization => organization1
    p2 = create_project :name => 'P2', :primary_organization => organization2
    p3 = create_project :name => 'P3', :primary_organization => organization1

    p1.countries << spain
    p2.countries << germany
    p3.countries << spain
    p1.countries << france
    p2.countries << france

    site1 = create_site :name => 'Food for Haiti 1', :project_context_organization_id => organization1.id, :project_context_cluster_id => nil, :url => 'http://site1.com'
    site2 = create_site :name => 'Food for Haiti 2', :project_context_organization_id => organization2.id, :project_context_cluster_id => nil, :url => 'http://site2.com'

    site1.reload
    site2.reload
    p1.reload
    p2.reload
    p3.reload

    assert_equal 2, spain.projects_count(site1)
    assert_equal 0, spain.projects_count(site2)
    assert_equal 0, germany.projects_count(site1)
    assert_equal 1, germany.projects_count(site2)
    assert_equal 1, france.projects_count(site1)
    assert_equal 1, france.projects_count(site2)

    p1.update_attribute(:end_date, Date.today.yesterday)
    assert_equal 1, spain.projects_count(site1)
  end

end
