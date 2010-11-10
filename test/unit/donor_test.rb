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
end
