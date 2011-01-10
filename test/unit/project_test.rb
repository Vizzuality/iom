require File.expand_path('../../test_helper', __FILE__)

class ProjectTest < ActiveSupport::TestCase

  test "Our data is valid" do
    project = create_project
    assert project.valid?
    assert !project.new_record?
  end

  test "Tag a project with a tag twice should create a tag and update the counter to 2" do
    project = create_project
    project.tags = 'tag1'
    project.save
    assert_equal 1, project.tags.size

    tag = Tag.last
    assert_equal 'tag1', tag.name
    assert_equal 1, tag.count
    assert_equal 1, project.tags.size

    project.tags = 'tag1'
    tag.reload
    assert_equal 1, tag.count
    assert_equal 1, project.tags.size

    project2 = create_project :name => "Another project"
    project2.tags = 'tag1'
    project2.save
    tag.reload
    assert_equal 1, project2.tags.size

    assert_equal 2, tag.count

    tag.reload
    assert_equal 2, tag.projects.size
  end

  test "Tag a project with multiple tags" do
    project = create_project
    project.tags = 'tag1, tag2'
    assert_equal 2, project.tags.count

    tag1 = Tag.find_by_name('tag1')
    assert_equal 1, tag1.count

    tag2 = Tag.find_by_name('tag2')
    assert_equal 1, tag2.count

    project.tags = 'tag2, tag3'
    project.reload
    assert_equal 2, project.tags.count

    tag1 = Tag.find_by_name('tag1')
    assert_equal 0, tag1.count

    tag2 = Tag.find_by_name('tag2')
    assert_equal 1, tag2.count

    tag3 = Tag.find_by_name('tag3')
    assert_equal 1, tag3.count
  end

  test "Dates consistency" do
    project = new_project
    project.end_date = project.start_date - 5.days
    project.save
    assert !project.valid?
    assert project.errors[:end_date]
  end

  test "Project regions and countries" do
    spain = create_country :name => 'Spain'
    valencia = create_region :name => 'Valencia', :country => spain
    project = create_project
    project.countries << spain
    project.regions << valencia

    assert project.countries.include?(spain)
    assert project.regions.include?(valencia)
  end


  test "Given a project with matches in a site criteria should be a cached_project" do
    organization = create_organization
    site = create_site :name => 'Food for Haiti', :project_context_organization_id => organization.id, :project_context_cluster_id => nil
    project = create_project :primary_organization_id => organization.id

    project.reload

    assert_equal 1, project.cached_sites.size
    assert project.cached_sites.include?(site)
  end

  test "Destroy a site should remove it from projects_sites" do
    organization = create_organization
    site = create_site :name => 'Food for Haiti', :project_context_organization_id => organization.id, :project_context_cluster_id => nil

    project = create_project :primary_organization_id => organization.id
    project.reload

    assert project.cached_sites.include?(site)

    site.destroy
    project.reload

    assert project.cached_sites.empty?
  end

  test "months left" do
    project = create_project :food_conservation
    project.update_attribute(:end_date, Date.today.tomorrow + 2.months)
    project.reload
    assert project.months_left >= 2
  end

  test "Project.custom_find method" do
    spain    = create_country :name => 'Spain'
    valencia = create_region :name => 'Valencia', :country => spain
    madrid   = create_region :name => 'Madrid', :country => spain

    c1 = create_cluster :name => 'C1'
    c2 = create_cluster :name => 'C2'
    c3 = create_cluster :name => 'C3'

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
  end

  test "saving a project with a big budget"do
    project = create_project :budget => 99999999999999999
    assert project.valid?
    assert_equal 99999999999999999, project.budget
  end

  test "saving a project with a big estimated people reached"do
    project = create_project :estimated_people_reached => 99999999999999999
    assert project.valid?
    assert_equal 99999999999999999, project.estimated_people_reached
  end
end
