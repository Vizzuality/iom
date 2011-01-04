require File.dirname(__FILE__) + '/acceptance_helper'

feature "Sites" do

  scenario "Create and update a site", :js => true do
    spain  = create_country :name => 'Spain'
    food   = create_cluster :name => 'food'
    africa = create_cluster :name => 'africa'

    project = create_project
    project.clusters << food
    project.countries << spain

    create_settings
    create_theme

    login_as_administrator

    click_link_or_button 'Add a new site'

    page.should have_css("h2", :text => 'Create a new site')

    within(:xpath, "//form[@action='/admin/sites']") do
      fill_in 'site_name', :with => 'Haiti Aid Map'
      fill_in 'site_short_description', :with => 'Haiti Aid Map short desc'
      fill_in 'site_long_description', :with => 'Haiti Aid Map long desc'
      find('#gc_limited_region a').click
      within '#gc_limited_region' do
        find('.country .selectedTxt', :text => 'Select a country').click
        click_link 'Spain'
      end
      find('#include_sector_cluster a').click
      within '#include_sector_cluster' do
        find('p.cluster_sector', :text => 'Select a cluster or a sector').click
        find('a.cluster_value', :text => 'food').click
      end

      fill_in 'site_contact_email', :with => 'contact@example.com'
      fill_in 'site_contact_person', :with => 'Haiti contact'
      fill_in 'site_subdomain', :with => 'test-iom-haiti'
      fill_in 'site_google_analytics_id', :with => 'GA-123'

      click_link_or_button 'Save'
    end

    site = Site.last
    assert_equal 'Haiti Aid Map', site.name
    assert_equal 'test-iom-haiti.ngoaidmap.org', site.url
    assert_equal spain.id, site.geographic_context_country_id
    assert_equal food.id, site.project_context_cluster_id
    assert_nil site.geographic_context_region_id
    assert_nil site.project_context_organization_id
    assert site.project_context_tags.blank?

    page.should have_css("h2", :text => 'Haiti Aid Map')

    within(:xpath, "//form[@action='/admin/sites/#{site.id}']") do
      attach_file('site_logo', "#{Rails.root}/test/support/images/caritas.jpg")
      find('div#classification_option span a#1').click
      find('input#site_show_blog').click
      fill_in 'tumblr', :with => 'tumblr_username'
      check 'site_show_global_donations_raises'
      fill_in 'site_word_for_clusters', :with => 'grupos'
      fill_in 'site_word_for_regions', :with => 'campos'
      fill_in 'site_level_for_region', :with => 2
      click_link_or_button 'Save'
    end

    site.reload
    assert site.valid?
    assert_equal 'grupos', site.word_for_clusters
    assert_equal 'campos', site.word_for_regions
    assert_equal 'tumblr_username', site.blog_url
    assert_equal 1, site.project_classification
    assert_equal 2, site.level_for_region

    click_link_or_button "Media"

    page.should have_css("h2", :text => 'Haiti Aid Map')

    find("a", :text => 'add a video').click

    within(:xpath, "//div[@id='new_video']/form[@action='/admin/sites/#{site.id}/media_resources']") do
      fill_in 'media_resource_vimeo_url', :with => 'http://vimeo.com/11144228'
      click_link_or_button 'save'
    end

    assert_equal 1, site.media_resources.count
    assert !site.media_resources.first.vimeo_url.blank?
    assert !site.media_resources.first.vimeo_embed_html.blank?

    page.should have_css("div.menu ul li", :text => 'Media')

    page.find('a.delete', :text => 'Delete').click
    within '#modal_window' do
      find('span a.remove', :text => 'delete').click
    end
    site.reload

    assert_equal 0, site.media_resources.count
    page.should have_css("div.menu ul li", :text => 'Media')

    click_link_or_button "Resources"

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

    page.should have_css("div.menu ul li", :text => 'Resources')

    page.find('a.delete', :text => 'Delete').click
    within '#modal_window' do
      find('span a.remove', :text => 'delete').click
    end
    site.reload

    assert_equal 0, site.resources.count
    page.should have_css("div.menu ul li", :text => 'Resources')

    click_link_or_button 'Customization'

    within('span.add_partner') do
      find('a.manage_partners', :text => 'Add a partner').click
    end

    within(:xpath, "//form[@action='/admin/sites/#{site.id}/partners']") do
      fill_in 'partner_name', :with => 'USA Gov'
      fill_in 'partner_url', :with => 'http://usa.gov'
      attach_file('partner_logo', "#{Rails.root}/test/support/images/usagov_logo.gif")
      click_link_or_button 'Add partner'
    end

    site.reload
    assert_equal 1, site.partners.count

    page.should have_css("h2", :text => 'Haiti Aid Map')
    page.should have_css("div.partner", :count => 1)

    page.find('div.partner a.delete', :text => 'Delete').click
    within '#modal_window' do
      find('span a.remove', :text => 'delete').click
    end
    site.reload

    assert_equal 0, site.partners.count

    click_link_or_button "Site projects"
    page.should have_css("h2", :text => 'Haiti Aid Map')
    page.should have_css("p", :text => '1 project within this site')
    page.should have_css("div.project h3 a", :text => project.name)

  end

  scenario 'Show site passing its id as an url parameter' do
    create_country(:name => 'Spain')
    create_country(:name => 'France')
    create_country(:name => 'Italy')

    site = create_site

    visit "/?force_site_id=#{site.id}"
    page.should have_css('#outer_layout h1', :text => 'Haiti Aid Map')

    click_link 'Spain'
    page.should have_css('#outer_layout h1', :text => 'Haiti Aid Map')

    click_link 'France'
    page.should have_css('#outer_layout h1', :text => 'Haiti Aid Map')

    click_link 'Italy'
    page.should have_css('#outer_layout h1', :text => 'Haiti Aid Map')

    visit "/?force_site_name=#{CGI::escape(site.name)}"
    page.should have_css('#outer_layout h1', :text => 'Haiti Aid Map')

    click_link 'Spain'
    page.should have_css('#outer_layout h1', :text => 'Haiti Aid Map')

    click_link 'France'
    page.should have_css('#outer_layout h1', :text => 'Haiti Aid Map')

    click_link 'Italy'
    page.should have_css('#outer_layout h1', :text => 'Haiti Aid Map')
  end
end
