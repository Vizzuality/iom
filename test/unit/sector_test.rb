require File.expand_path('../../test_helper', __FILE__)

class SectorTest < ActiveSupport::TestCase

  test "Our data is valid" do
    sector = create_sector :name => 'food'
    assert sector.valid?
    assert !sector.new_record?
    assert_equal 'food', sector.name
  end
end
