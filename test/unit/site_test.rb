require File.expand_path('../../test_helper', __FILE__)

class SiteTest < ActiveSupport::TestCase

  test "Create a site should strip html tags" do
    site = create_site :name => "<strong>Name</strong>", :short_description => "<em>Short Description</em>"
    assert site.valid?
    assert_equal 'Name', site.name
    assert_equal 'Short Description', site.short_description
  end

  test "Our data is valid" do
    tag1 = create_tag :name => 'asia'
    tag2 = create_tag :name => 'africa'
    cluster = create_cluster :name => 'food'
    site = create_site  :name => 'Haiti Aid Map', :short_description => 'Haiti Aid Map short desc',
                        :long_description => 'Haiti Aid Map long desc',
                        :contact_email => 'contact@example.com', :contact_person => 'Haiti Contact Person',
                        :url => 'http://haiti.aidmap.com', :google_analytics_id => 'GA-1234-321',
                        :blog_url => '', :word_for_clusters => 'clisters', :word_for_regions => 'rigions',
                        :geographic_context => 'worlwide',
                        :geographic_context_country_id => 3,
                        :show_global_donations_raises => true,
                        :project_context => ['clusters', 'tags'],
                        :project_context_cluster_id => cluster.id,
                        :project_context_organization_id => 3,
                        :project_context_tags => "#{tag1.name},   #{tag2.name}, non_existing_tag"
    assert site.valid?
    site.reload
    assert !site.new_record?
    assert_equal "#{tag1.id},#{tag2.id}", site.project_context_tags_ids
    assert_nil site.project_context_organization_id
    assert_nil site.geographic_context_country_id
  end


  test "Projects filtering by sector, tags and region" do
    spain = create_country :name => 'Spain'
    valencia = create_region :name => 'Valencia', :country => spain
    madrid = create_region :name => 'Madrid', :country => spain

    s1 = create_sector :name => 's1'
    s2 = create_sector :name => 's2'

    p1 = new_project :name => 'P1', :tags => 't1, t2, t3'
    p1.save
    p1.regions << valencia
    p1.sectors << s1

    p2 = new_project :name => 'P2', :tags => 't1, t2, t3'
    p2.save
    p2.regions << valencia
    p2.sectors << s1

    p3 = new_project :name => 'P3'
    p3.save
    p3.regions << madrid

    p4 = new_project :name => 'P4', :tags => 't1, t2, t3'
    p4.save
    p4.sectors << s1
    p4.sectors << s2
    p4.regions << valencia

    p5 = new_project :name => 'P5'
    p5.save

    # New site:
    #  - tags filtering:    t2
    #  - region filtering : valencia
    #  - sector filtering:  s1

    # Projects: should return projects P1, P2 and P4
    s = Site.new :name => 'Brand new site', :url => 'www.brand-new-site.com', :project_context_tags => 't2,t4', :geographic_context_region_id => valencia.id, :project_context_sector_id => s1.id
    s.save
    assert s.valid?

    assert_equal 3, s.projects.size
    assert s.projects.include?(p1)
    assert s.projects.include?(p2)
    assert s.projects.include?(p4)
  end

  test "After create site, pages associated to the site are created" do
    site = create_site
    assert !site.pages.empty?
    assert site.pages.map(&:title).include?('About')
    assert site.pages.map(&:title).include?('Contact')
    assert site.pages.map(&:title).include?('Analysis')
  end

  test "Given a project with matches in a site criteria should be a cached_project" do
    organization = create_organization
    project = create_project :primary_organization_id => organization.id

    site = create_site :name => 'Food for Haiti', :project_context_organization_id => organization.id, :project_context_cluster_id => nil
    site.reload

    assert_equal 1, site.cached_projects.size
    assert site.cached_projects.include?(project)
  end

  test "Destroy a project should remove it from projects_sites" do
    organization = create_organization
    project = create_project :primary_organization_id => organization.id
    site = create_site :name => 'Food for Haiti', :project_context_organization_id => organization.id, :project_context_cluster_id => nil

    site.reload

    assert site.cached_projects.include?(project)

    project.destroy

    site.reload

    assert site.cached_projects.empty?
  end

  test "should concatenate the defaut domain to the site url" do
    site = create_site :url => 'test'
    assert site.valid?
    assert_equal site.complete_url, 'test.ngoaidmap.org'
  end

end