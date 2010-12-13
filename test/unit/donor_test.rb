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
  
end
