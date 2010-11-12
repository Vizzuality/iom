require File.expand_path('../../test_helper', __FILE__)

class TagTest < ActiveSupport::TestCase

  test "Our data is valid" do
    tag = create_tag :name => 'tag1'
    assert tag.valid?
    assert_equal 'tag1', tag.name
    assert_equal 0, tag.count
  end

end
