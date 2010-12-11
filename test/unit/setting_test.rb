require File.expand_path('../../test_helper', __FILE__)

class SettingTest < ActiveSupport::TestCase

  def test_our_data_is_valid
    setting = create_setting
    assert_not_nil setting.data
    assert setting.data.is_a?(Hash)
    setting.data[:wadus] = 'tradus'
    setting.save
    setting.reload
    assert_equal 'tradus', setting.data[:wadus]
  end

end
