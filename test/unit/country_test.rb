require File.expand_path('../../test_helper', __FILE__)

class CountryTest < ActiveSupport::TestCase

  test "Updates wikipedia description on save" do
    wikipedia_url = 'http://en.wikipedia.org/wiki/Dominican_republic'
    dominican_republic = Country.create(:name => 'Dominican Republic', :wiki_url => wikipedia_url)
    assert dominican_republic.wiki_description.present?
    assert_match 'The Dominican Republic (i/dəˌmɪnɪkən rɪˈpʌblɪk/; Spanish: República Dominicana,', dominican_republic.wiki_description
  end
end
