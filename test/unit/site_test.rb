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
                        :project_context_tags => "#{tag1.name},   #{tag2.name}"
    assert site.valid?
    site.reload
    assert !site.new_record?
    assert_equal "#{tag1.id},#{tag2.id}", site.project_context_tags_ids
    assert_nil site.project_context_organization_id
    assert_nil site.geographic_context_country_id
  end

end
