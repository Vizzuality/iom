require File.dirname(__FILE__) + '/acceptance_helper'

feature "Pages" do

  scenario "Manage pages from a site" do
    site = create_site

    login_as_administrator

    click_link_or_button 'Manage Sites'

    click_link_or_button site.name

    click_link_or_button "Pages (0)"

    page.should have_css("h2", :text => "Pages from #{site.name}")

    click_link_or_button '+ new page'

    within(:xpath, "//form[@action='/admin/sites/#{site.id}/pages']") do
      fill_in 'page_title', :with => 'FAQ'
      fill_in 'page_body', :with => '<p>p1</p><p>p2</p>'
      check 'page_highlighted'
      click_link_or_button 'Save'
    end

    site.reload
    assert_equal 1, site.pages.count
    site_page = site.pages.first
    assert_equal 'FAQ', site_page.title
    assert_equal '<p>p1</p><p>p2</p>', site_page.body
    assert site_page.highlighted?

    click_link_or_button '⟵ back to pages'

    page.should have_css("ul li a", :text => 'FAQ')

    click_link_or_button 'FAQ'

    within(:xpath, "//form[@action='/admin/sites/#{site.id}/pages/#{site_page.id}']") do
      fill_in 'page_title', :with => 'FAQ 2'
      click_link_or_button 'Save'
    end

    site_page.reload
    assert_equal 'FAQ 2', site_page.title

    click_link_or_button '⟵ back to pages'

    click_link_or_button 'Delete'

    site.reload
    assert_equal 0, site.pages.count
  end
end
