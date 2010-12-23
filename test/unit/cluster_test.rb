require File.expand_path('../../test_helper', __FILE__)

class ClusterTest < ActiveSupport::TestCase

  test "Our data is valid" do
    cluster = create_cluster :name => 'food'
    assert cluster.valid?
    assert !cluster.new_record?
    assert_equal 'food', cluster.name
  end

  test "donors of a site" do
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

    assert_equal 2, c1.donors(site1).size
    assert c1.donors(site1).include?(donor1)
    assert c1.donors(site1).include?(donor3)

    assert_equal 0, c1.donors(site2).size
    assert_equal 0, c2.donors(site1).size

    assert_equal 1, c2.donors(site2).size
    assert c2.donors(site2).include?(donor2)

    assert_equal 1, c3.donors(site1).size
    assert c3.donors(site1).include?(donor3)
    assert_equal 0, c3.donors(site2).size
  end

  test "projects_regions of a site" do
    spain    = create_country :name => 'Spain'
    valencia = create_region :name => 'Valencia', :country => spain, :level => 1
    madrid   = create_region :name => 'Madrid', :country => spain,   :level => 1
    lerida   = create_region :name => 'Lerida', :country => spain,   :level => 2

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

    p1.regions << valencia
    p1.regions << madrid
    p2.regions << madrid
    p1.regions << lerida

    site1 = create_site :name => 'Food for Haiti 1', :project_context_organization_id => organization1.id, :project_context_cluster_id => nil, :url => 'http://site1.com'
    site2 = create_site :name => 'Food for Haiti 2', :project_context_organization_id => organization2.id, :project_context_cluster_id => nil, :url => 'http://site2.com'

    site1.reload
    site2.reload
    p1.reload
    p2.reload
    p3.reload

    assert_equal 2, c1.projects_regions(site1).size
    assert c1.projects_regions(site1).flatten.include?(valencia)
    assert c1.projects_regions(site1).flatten.include?(madrid)

    assert_equal 1, c2.projects_regions(site2).size
    assert c2.projects_regions(site2).flatten.include?(madrid)

    assert_equal 0, c2.projects_regions(site1).size
    assert_equal 0, c1.projects_regions(site2).size
  end

end
