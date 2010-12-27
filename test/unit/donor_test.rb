require File.expand_path('../../test_helper', __FILE__)

class DonorTest < ActiveSupport::TestCase

  test "Create a donor should strip html tags" do
    donor = create_donor :name => "<strong>Name</strong>", :description => "<em>Short Description</em>"
    assert donor.valid?
    assert_equal 'Name', donor.name
    assert_equal 'Short Description', donor.description
  end

  test "Our data is valid" do
    donor = create_donor
    assert donor.valid?
    assert !donor.new_record?
  end

  test "Donor specific_information" do
    donor = create_donor
    site = create_site

    assert_nil donor.attributes_for_site(site)

    atts = {:name => "Donor name fro site #{site.id}"}
    donor.attributes_for_site = {:donor_values => atts, :site_id => site.id}

    assert donor.valid?

    assert_equal "Donor name fro site #{site.id}", donor.attributes_for_site(site)[:name]
  end

  test "donations_amount" do
    project = create_project
    donor = create_donor

    project.donations.create! :donor => donor, :amount => 100
    project.donations.create! :donor => donor, :amount => 200
    project.donations.create! :donor => donor, :amount => 300

    assert_equal 600, donor.donations_amount
  end

  test "projects_clusters of a site" do
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

    assert_equal 1, donor1.projects_clusters(site1).size
    assert donor1.projects_clusters(site1).flatten.include?(c1)

    assert_equal 0, donor1.projects_clusters(site2).size

    assert_equal 0, donor2.projects_clusters(site1).size
    assert_equal 1, donor2.projects_clusters(site2).size
    assert donor2.projects_clusters(site2).flatten.include?(c2)

    assert_equal 2, donor3.projects_clusters(site1).size
    assert donor3.projects_clusters(site1).flatten.include?(c3)
    assert donor3.projects_clusters(site1).flatten.include?(c1)
    assert_equal 0, donor3.projects_clusters(site2).size
  end

  test "projects_regions of a site" do
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

    assert_equal 2, donor1.projects_regions(site1).size
    assert donor1.projects_regions(site1).flatten.include?(valencia)
    assert donor1.projects_regions(site1).flatten.include?(madrid)
    assert_equal 0, donor1.projects_regions(site2).size

    assert_equal 0, donor2.projects_regions(site1).size
    assert_equal 1, donor2.projects_regions(site2).size
    assert donor2.projects_regions(site2).flatten.include?(berlin)

    assert_equal 1, donor3.projects_regions(site1).size
    assert donor3.projects_regions(site1).flatten.include?(valencia)
    assert_equal 0, donor3.projects_regions(site2).size
  end

end
