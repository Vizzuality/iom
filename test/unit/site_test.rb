require File.expand_path('../../test_helper', __FILE__)

class SiteTest < ActiveSupport::TestCase

  test "Create a site should strip html tags" do
    site = create_site :name => "<strong>Name</strong>", :short_description => "<em>Short Description</em>"
    assert site.valid?
    assert_equal 'Name', site.name
    assert_equal 'Short Description', site.short_description
  end

  test "Our data is valid" do
    site = create_site :food_security
    assert site.valid?
    assert !site.new_record?
  end

end
