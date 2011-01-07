require File.expand_path('../../test_helper', __FILE__)

class OrganizationTest < ActiveSupport::TestCase

  test "Our data is valid" do
    organization = create_organization
    assert organization.valid?
    assert !organization.new_record?
  end

  test "Organization specific_information" do
    organization = create_organization
    site = create_site :project_context_organization_id => organization.id

    assert_nil organization.attributes_for_site(site)

    atts = {:name => "Organization name fro site #{site.id}"}
    organization.attributes_for_site = {:organization_values => atts, :site_id => site.id}

    assert organization.valid?

    assert_equal "Organization name fro site #{site.id}", organization.attributes_for_site(site)[:name]
  end

  test "organization projects_clusters_sectors of a site navigated by clusters" do
    spain    = create_country :name => 'Spain'
    valencia = create_region :name => 'Valencia', :country => spain
    madrid   = create_region :name => 'Madrid', :country => spain

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

    site1 = create_site :name => 'Food for Haiti 1', :project_context_organization_id => organization1.id, :project_context_cluster_id => nil, :url => 'http://site1.com'
    site2 = create_site :name => 'Food for Haiti 2', :project_context_organization_id => organization2.id, :project_context_cluster_id => nil, :url => 'http://site2.com'

    site1.reload
    site2.reload
    p1.reload
    p2.reload
    p3.reload

    assert_equal 2, organization1.projects_clusters_sectors(site1).size
    assert organization1.projects_clusters_sectors(site1).flatten.include?(c1)
    assert organization1.projects_clusters_sectors(site1).flatten.include?(c3)

    assert_equal 0, organization2.projects_clusters_sectors(site1).size

    assert_equal 0, organization1.projects_clusters_sectors(site2).size

    assert_equal 1, organization2.projects_clusters_sectors(site2).size
    assert organization2.projects_clusters_sectors(site2).flatten.include?(c2)

    p2.update_attribute(:end_date, Date.today.yesterday)
    assert_equal 0, organization2.projects_clusters_sectors(site2).size
  end

  test "organization projects_clusters_sectors of a site navigated by sectors" do
    spain    = create_country :name => 'Spain'
    valencia = create_region :name => 'Valencia', :country => spain
    madrid   = create_region :name => 'Madrid', :country => spain

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

    assert_equal 2, organization1.projects_clusters_sectors(site1).size
    assert organization1.projects_clusters_sectors(site1).flatten.include?(s1)
    assert organization1.projects_clusters_sectors(site1).flatten.include?(s3)

    assert_equal 0, organization2.projects_clusters_sectors(site1).size

    assert_equal 0, organization1.projects_clusters_sectors(site2).size

    assert_equal 1, organization2.projects_clusters_sectors(site2).size
    assert organization2.projects_clusters_sectors(site2).flatten.include?(s2)

    p2.update_attribute(:end_date, Date.today.yesterday)
    assert_equal 0, organization2.projects_clusters_sectors(site2).size
  end

  test "organization projects_regions of a site" do
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

    assert_equal 2, organization1.projects_regions(site1).size
    assert organization1.projects_regions(site1).flatten.include?(valencia)
    assert organization1.projects_regions(site1).flatten.include?(madrid)
    assert_equal 0, organization1.projects_regions(site2).size

    assert_equal 0, organization2.projects_regions(site1).size
    assert_equal 1, organization2.projects_regions(site2).size
    assert organization2.projects_regions(site2).flatten.include?(berlin)

    p1.update_attribute(:end_date, Date.today.yesterday)
    assert_equal 1, organization1.projects_regions(site1).size
    assert organization1.projects_regions(site1).flatten.include?(valencia)
  end

  test "organization projects_count of a site" do
    spain    = create_country :name => 'Spain'
    valencia = create_region :name => 'Valencia', :country => spain
    madrid   = create_region :name => 'Madrid', :country => spain

    organization1 = create_organization
    organization2 = create_organization

    p1 = create_project :name => 'P1', :primary_organization => organization1
    p2 = create_project :name => 'P2', :primary_organization => organization2
    p3 = create_project :name => 'P3', :primary_organization => organization1

    site1 = create_site :name => 'Food for Haiti 1', :project_context_organization_id => organization1.id, :project_context_cluster_id => nil, :url => 'http://site1.com'
    site2 = create_site :name => 'Food for Haiti 2', :project_context_organization_id => organization2.id, :project_context_cluster_id => nil, :url => 'http://site2.com'

    site1.reload
    site2.reload
    p1.reload
    p2.reload
    p3.reload

    assert_equal 2, organization1.projects_count(site1)
    assert_equal 0, organization1.projects_count(site2)
    assert_equal 0, organization2.projects_count(site1)
    assert_equal 1, organization2.projects_count(site2)

    p1.update_attribute(:end_date, Date.today.yesterday)
    assert_equal 1, organization1.projects_count(site1)
  end

  test "saving an organization with a big budget"do
    organization = create_organization :budget => 99999999999999999
    assert organization.valid?
    assert_equal 99999999999999999, organization.budget
  end

end
