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

  test "Organization specific_information" do
    organization = create_organization
    site = create_site :project_context_organization_id => organization.id

    assert_nil organization.attributes_for_site(site)

    atts = {:name => "Organization name fro site #{site.id}"}
    organization.attributes_for_site = {:organization_values => atts, :site_id => site.id}

    assert organization.valid?

    assert_equal "Organization name fro site #{site.id}", organization.attributes_for_site(site)[:name]
  end

end
