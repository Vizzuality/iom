require File.expand_path('../../test_helper', __FILE__)

class OrganizationTest < ActiveSupport::TestCase

  test "Create an organization should strip html tags" do
    organization = create_organization :name => "<strong>Name</strong>", :description => "<em>Short Description</em>"
    assert organization.valid?
    assert_equal 'Name', organization.name
    assert_equal 'Short Description', organization.description
  end

  test "Our data is valid" do
    organization = create_organization
    assert organization.valid?
    assert !organization.new_record?
  end

end
