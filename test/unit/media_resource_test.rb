require File.expand_path('../../test_helper', __FILE__)

class MediaResourceTest < ActiveSupport::TestCase

  test "Our data is valid" do
    resource1 = create_media_resource :food_picture
    assert resource1.valid?
    assert !resource1.new_record?
    assert_not_nil resource1.project

    resource2 = new_media_resource :food_video
    resource2.element = create_organization
    resource2.save
    assert resource2.valid?
    assert !resource2.new_record?
    assert_not_nil resource2.organization
  end

  test "A resource is set to the last position when created" do
    resource1 = create_media_resource :food_picture
    assert_equal 0, resource1.position
    resource2 = new_media_resource :food_video
    resource2.element = resource1.project
    resource2.save
    assert_equal 1, resource2.position
  end

end
