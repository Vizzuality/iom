require File.dirname(__FILE__) + '/acceptance_helper'

feature "Sites" do

  scenario "Create and update a site" do
    spain = create_country :name => 'Spain'
    food = create_cluster :name => 'food'
    africa = create_cluster :name => 'africa'

    login_as_administrator

    click_link_or_button 'Manage Sites'

    click_link_or_button '+ new site'

    page.should have_css("h2", :text => 'New site')

    within(:xpath, "//form[@action='/admin/sites']") do
      fill_in 'site_name', :with => 'Haiti Aid Map'
      fill_in 'site_short_description', :with => 'Haiti Aid Map short desc'
      fill_in 'site_long_description', :with => 'Haiti Aid Map long desc'
      choose  'gc_limited_country'
      select  'Spain', :from => 'gc_limited_country_section'
      check   'pc_cluster'
      select  'food', :from => 'pc_cluster_section'
      fill_in 'site_contact_email', :with => 'contact@example.com'
      fill_in 'site_contact_person', :with => 'Haiti contact'
      fill_in 'site_url', :with => 'www.haitimap.com'
      fill_in 'site_google_analytics_id', :with => 'GA-123'
      click_link_or_button 'Save'
    end

    site = Site.last
    assert_equal 'Haiti Aid Map', site.name
    assert_equal 'www.haitimap.com', site.url
    assert_equal spain.id, site.geographic_context_country_id
    assert_equal food.id, site.project_context_cluster_id
    assert_nil site.geographic_context_region_id
    assert_nil site.project_context_organization_id
    assert_nil site.project_context_tags

    page.should have_css("h2", :text => 'Edit site Haiti Aid Map')

    within(:xpath, "//form[@action='/admin/sites/#{site.id}']") do
      attach_file('site_logo', "#{Rails.root}/test/support/images/caritas.jpg")
      choose 'site_project_classification_1'
      fill_in 'site_blog_url', :with => 'tumblr_username'
      check 'site_show_global_donations_raises'
      fill_in 'site_word_for_clusters', :with => 'grupos'
      fill_in 'site_word_for_regions', :with => 'campos'
      click_link_or_button 'Save'
    end

    site.reload
    assert site.valid?
    assert_equal 'grupos', site.word_for_clusters
    assert_equal 'campos', site.word_for_regions
    assert_equal 'tumblr_username', site.blog_url
    assert_equal 1, site.project_classification

    click_link_or_button "Media (0)"

    page.should have_css("h2", :text => 'Haiti Aid Map')

    within(:xpath, "//div[@id='new_video']/form[@action='/admin/sites/#{site.id}/media_resources']") do
      fill_in 'media_resource_vimeo_url', :with => 'http://vimeo.com/11144228'
      click_link_or_button 'save'
    end

    assert_equal 1, site.media_resources.count
    assert !site.media_resources.first.vimeo_url.blank?
    assert !site.media_resources.first.vimeo_embed_html.blank?

    page.should have_css("div.sidebar ul li", :text => 'Media (1)')

    click_link_or_button 'Delete'

    assert_equal 0, site.media_resources.count
    page.should have_css("div.sidebar ul li", :text => 'Media (0)')

    click_link_or_button "Resources (0)"

    page.should have_css("h2", :text => 'Haiti Aid Map')
    page.should have_css("p", :text => '0 resources')

    within(:xpath, "//form[@action='/admin/sites/#{site.id}/resources']") do
      fill_in 'resource_title', :with => 'PDF Report'
      fill_in 'resource_url',   :with => 'http://www.report.com/report.pdf'
      click_link_or_button 'add resource'
    end

    assert_equal 1, site.resources.count
    assert_equal 'PDF Report', site.resources.first.title
    assert_equal 'http://www.report.com/report.pdf', site.resources.first.url

    page.should have_css("div.sidebar ul li", :text => 'Resources (1)')

    click_link_or_button 'Delete'

    assert_equal 0, site.resources.count
    page.should have_css("div.sidebar ul li", :text => 'Resources (0)')

    click_link_or_button 'Customization'

    within(:xpath, "//form[@action='/admin/sites/#{site.id}/partners']") do
      fill_in 'partner_name', :with => 'USA Gov'
      fill_in 'partner_url', :with => 'http://usa.gov'
      attach_file('partner_logo', "#{Rails.root}/test/support/images/usagov_logo.gif")
      click_link_or_button 'Add partner'
    end

    assert_equal 1, site.partners.count

    page.should have_css("h2", :text => 'Edit site Haiti Aid Map')
    page.should have_css("div.partner", :count => 1)

    click_link_or_button 'Delete'
    assert_equal 0, site.partners.count

  end
end
