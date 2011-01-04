require File.expand_path('../../test_helper', __FILE__)

class RegionTest < ActiveSupport::TestCase

  # should list the clusters of the projects in one site that belongs to a given country
  test "projects_clusters_sectors of a site navigated by cluster" do
    spain    = create_country :name => 'Spain'
    germany  = create_country :name => 'Germany'

    valencia = create_region :name => 'Valencia', :country => spain, :level => 1
    madrid   = create_region :name => 'Madrid', :country => spain,   :level => 1
    lerida   = create_region :name => 'Lerida', :country => spain,   :level => 2

    berlin   = create_region :name => 'Berlin', :country => germany, :level => 1
    dresden  = create_region :name => 'Berlin', :country => germany, :level => 2

    c1 = create_cluster
    c2 = create_cluster
    c3 = create_cluster

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

    p1.clusters << c1
    p2.clusters << c2
    p3.clusters << c3
    p3.clusters << c1

    site1 = create_site :name => 'Food for Haiti 1', :project_context_organization_id => organization1.id, :project_context_cluster_id => nil, :url => 'http://site1.com'
    site2 = create_site :name => 'Food for Haiti 2', :project_context_organization_id => organization2.id, :project_context_cluster_id => nil, :url => 'http://site2.com'

    site1.reload
    site2.reload
    p1.reload
    p2.reload
    p3.reload

    assert_equal 2, valencia.projects_clusters_sectors(site1).size
    assert valencia.projects_clusters_sectors(site1).flatten.include?(c1)
    assert valencia.projects_clusters_sectors(site1).flatten.include?(c3)

    assert_equal 0, valencia.projects_clusters_sectors(site2).size

    assert_equal 0, berlin.projects_clusters_sectors(site1).size
    assert_equal 1, berlin.projects_clusters_sectors(site2).size

    assert berlin.projects_clusters_sectors(site2).flatten.include?(c2)

    p3.update_attribute(:end_date, Date.today.yesterday)
    assert_equal 1, valencia.projects_clusters_sectors(site1).size
    assert valencia.projects_clusters_sectors(site1).flatten.include?(c1)
  end

  test "projects_clusters_sectors of a site navigated by sector" do
    spain    = create_country :name => 'Spain'
    germany  = create_country :name => 'Germany'

    valencia = create_region :name => 'Valencia', :country => spain, :level => 1
    madrid   = create_region :name => 'Madrid', :country => spain,   :level => 1
    lerida   = create_region :name => 'Lerida', :country => spain,   :level => 2

    berlin   = create_region :name => 'Berlin', :country => germany, :level => 1
    dresden  = create_region :name => 'Berlin', :country => germany, :level => 2

    s1 = create_sector
    s2 = create_sector
    s3 = create_sector

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

    p1.sectors << s1
    p2.sectors << s2
    p3.sectors << s3
    p3.sectors << s1

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

    assert_equal 2, valencia.projects_clusters_sectors(site1).size
    assert valencia.projects_clusters_sectors(site1).flatten.include?(s1)
    assert valencia.projects_clusters_sectors(site1).flatten.include?(s3)

    assert_equal 0, valencia.projects_clusters_sectors(site2).size

    assert_equal 0, berlin.projects_clusters_sectors(site1).size
    assert_equal 1, berlin.projects_clusters_sectors(site2).size

    assert berlin.projects_clusters_sectors(site2).flatten.include?(s2)

    p3.update_attribute(:end_date, Date.today.yesterday)
    assert_equal 1, valencia.projects_clusters_sectors(site1).size
    assert valencia.projects_clusters_sectors(site1).flatten.include?(s1)
  end

  # should list the regions of the projects in one site that belongs to a given country
  test "regions projects_organizations of a site" do
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

    assert_equal 1, valencia.projects_organizations(site1).size
    assert valencia.projects_organizations(site1).flatten.include?(organization1)
    assert_equal 0, valencia.projects_organizations(site2).size

    assert_equal 1, madrid.projects_organizations(site1).size
    assert madrid.projects_organizations(site1).flatten.include?(organization1)
    assert_equal 0, madrid.projects_organizations(site2).size

    assert_equal 0, berlin.projects_organizations(site1).size
    assert_equal 1, berlin.projects_organizations(site2).size
    assert berlin.projects_organizations(site2).flatten.include?(organization2)

    p1.update_attribute(:end_date, Date.today.yesterday)
    assert_equal 0, madrid.projects_organizations(site1).size
  end

  test "region donors and donors count of a site" do
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

    assert_equal 2, valencia.donors_count(site1)
    assert_equal 0, valencia.donors_count(site2)
    assert_equal 0, berlin.donors_count(site1)
    assert_equal 1, berlin.donors_count(site2)
    assert_equal 1, madrid.donors_count(site1)
    assert_equal 0, madrid.donors_count(site2)

    assert valencia.donors(site1).include?(donor1)
    assert valencia.donors(site1).include?(donor3)
    assert berlin.donors(site2).include?(donor2)
    assert madrid.donors(site1).include?(donor1)
  end

  test "projects_count of a site" do
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

    assert_equal 2, valencia.projects_count(site1)
    assert_equal 0, valencia.projects_count(site2)
    assert_equal 0, berlin.projects_count(site1)
    assert_equal 1, berlin.projects_count(site2)
    assert_equal 1, madrid.projects_count(site1)
    assert_equal 0, madrid.projects_count(site2)
  end

end
