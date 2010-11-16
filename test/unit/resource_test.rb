require File.expand_path('../../test_helper', __FILE__)

class ResourceTest < ActiveSupport::TestCase

  test "Our data is valid" do
    resource = create_resource
    assert resource.valid?
    assert !resource.new_record?
    assert_not_nil resource.project
  end
end
