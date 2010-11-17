require File.expand_path('../../test_helper', __FILE__)

class ClusterTest < ActiveSupport::TestCase

  test "Our data is valid" do
    cluster = create_cluster :name => 'food'
    assert cluster.valid?
    assert !cluster.new_record?
    assert_equal 'food', cluster.name
  end
end
