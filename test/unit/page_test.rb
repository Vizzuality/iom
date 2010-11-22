require File.expand_path('../../test_helper', __FILE__)

class PageTest < ActiveSupport::TestCase

  test "Our data is valid" do
    page = create_page
    assert page.valid?
    assert !page.new_record?
    assert_equal 'faq', page.permalink
  end
end
