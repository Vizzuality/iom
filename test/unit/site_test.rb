require File.expand_path('../../test_helper', __FILE__)

class SiteTest < ActiveSupport::TestCase

  test "Create a site should strip html tags" do
    site = create_site :name => "<strong>Name</strong>", :short_description => "<em>Short Description</em>"
    assert site.valid?
    assert_equal 'Name', site.name
    assert_equal 'Short Description', site.short_description
  end

  test "Our data is valid" do
    cluster = create_cluster :name => 'food'
    site = create_site  :name => 'Haiti Aid Map', :short_description => 'Haiti Aid Map short desc',
                        :long_description => 'Haiti Aid Map long desc',
                        :contact_email => 'contact@example.com', :contact_person => 'Haiti Contact Person',
                        :url => 'http://haiti.aidmap.com', :google_analytics_id => 'GA-1234-321',
                        :blog_url => '', :word_for_clusters => 'clisters', :word_for_regions => 'rigions',
                        :show_global_donations_raises => true,
                        :project_context_cluster_id => cluster.id
    assert site.valid?
    assert !site.new_record?
  end

end
