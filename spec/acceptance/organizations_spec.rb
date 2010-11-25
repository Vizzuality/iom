require File.dirname(__FILE__) + '/acceptance_helper'

feature "Organizations" do

  scenario "Create and update an organization" do
    login_as_administrator

    click_link_or_button 'Manage Organizations'

    click_link_or_button '+ new organization'

    within(:xpath, "//form[@action='/admin/organizations']") do
      fill_in 'organization_name', :with => 'Caritas'
      fill_in 'organization_description', :with => 'Caritas is a non-profit organization'
      attach_file('organization_logo', "#{Rails.root}/test/support/images/caritas.jpg")
      fill_in 'organization_budget', :with => '200000'
      fill_in 'organization_website', :with => 'http://caritas.org'
      fill_in 'organization_staff', :with => '1500'
      fill_in 'organization_twitter', :with => 'caritas'
      fill_in 'organization_facebook', :with => 'www.facebook.com/caritas'
      fill_in 'organization_hq_address', :with => 'Peace St, 3'
      fill_in 'organization_contact_email', :with => 'caritas@exampe.com'
      fill_in 'organization_contact_phone_number', :with => '0031 111 11 11'
      fill_in 'organization_donation_address', :with => '(Donations) Peace St, 3'
      fill_in 'organization_zip_code', :with => '28005'
      fill_in 'organization_city', :with => 'New York'
      fill_in 'organization_state', :with => 'NY'
      fill_in 'organization_donation_phone_number', :with => '0031 111 11 12'
      fill_in 'organization_donation_website', :with => 'http://caritas.com/donations'
      click_link_or_button 'Save'
    end

    assert_equal 1, Organization.count
    caritas = Organization.last
    assert caritas.valid?

    page.should have_css("h2", :text => "Edit organization Caritas")

    visit "/admin/organizations"

    page.should have_css("h2", :text => "Organizations")

    click_link_or_button "Caritas"

    page.should have_css("h2", :text => "Edit organization Caritas")

    within(:xpath, "//form[@action='/admin/organizations/#{caritas.id}']") do
      fill_in 'organization_budget', :with => '200001'
      click_link_or_button 'Save'
    end

    page.should have_css("h2", :text => "Edit organization Caritas")

    caritas.reload

    assert_equal 200001, caritas.budget

    click_link_or_button 'Delete this Organization'

    page.should have_css("h2", :text => "Organizations")

    assert_nil Organization.find_by_id(caritas.id)

  end

  scenario "Organization resources" do
    login_as_administrator

    click_link_or_button 'Manage Organizations'

    click_link_or_button '+ new organization'

    within(:xpath, "//form[@action='/admin/organizations']") do
      fill_in 'organization_name', :with => 'Caritas'
      fill_in 'organization_description', :with => 'Caritas is a non-profit organization'
      attach_file('organization_logo', "#{Rails.root}/test/support/images/caritas.jpg")
      fill_in 'organization_budget', :with => '200000'
      fill_in 'organization_website', :with => 'http://caritas.org'
      fill_in 'organization_staff', :with => '1500'
      fill_in 'organization_twitter', :with => 'caritas'
      fill_in 'organization_facebook', :with => 'www.facebook.com/caritas'
      fill_in 'organization_hq_address', :with => 'Peace St, 3'
      fill_in 'organization_contact_email', :with => 'caritas@exampe.com'
      fill_in 'organization_contact_phone_number', :with => '0031 111 11 11'
      fill_in 'organization_donation_address', :with => '(Donations) Peace St, 3'
      fill_in 'organization_zip_code', :with => '28005'
      fill_in 'organization_city', :with => 'New York'
      fill_in 'organization_state', :with => 'NY'
      fill_in 'organization_donation_phone_number', :with => '0031 111 11 12'
      fill_in 'organization_donation_website', :with => 'http://caritas.com/donations'
      click_link_or_button 'Save'
    end

    assert_equal 1, Organization.count
    caritas = Organization.last
    assert caritas.valid?

    # Associate a new project to this organization
    project = new_project
    project.primary_organization = caritas
    project.save
    assert project.valid?

    page.should have_css("div.sidebar ul li", :text => 'Basic information')

    click_link_or_button "Resources (0)"

    page.should have_css("h2", :text => 'Caritas')
    page.should have_css("p", :text => '0 resources')

    within(:xpath, "//form[@action='/admin/organizations/#{caritas.id}/resources']") do
      fill_in 'resource_title', :with => 'PDF Report'
      fill_in 'resource_url',   :with => 'http://www.report.com/report.pdf'
      click_link_or_button 'add resource'
    end

    assert_equal 1, caritas.resources.count
    assert_equal 'PDF Report', caritas.resources.first.title
    assert_equal 'http://www.report.com/report.pdf', caritas.resources.first.url

    page.should have_css("div.sidebar ul li", :text => 'Resources (1)')

    click_link_or_button 'Delete'

    assert_equal 0, caritas.resources.count
    page.should have_css("div.sidebar ul li", :text => 'Resources (0)')

    click_link_or_button 'Organization projects (1)'

    page.should have_css("p", :text => '1 project by this Organization')
    page.should have_css("div.project h3", :text => project.name)

    click_link_or_button 'Create a new project'

  end

  scenario "Organization media resources" do
    login_as_administrator

    click_link_or_button 'Manage Organizations'

    click_link_or_button '+ new organization'

    within(:xpath, "//form[@action='/admin/organizations']") do
      fill_in 'organization_name', :with => 'Caritas'
      fill_in 'organization_description', :with => 'Caritas is a non-profit organization'
      attach_file('organization_logo', "#{Rails.root}/test/support/images/caritas.jpg")
      fill_in 'organization_budget', :with => '200000'
      fill_in 'organization_website', :with => 'http://caritas.org'
      fill_in 'organization_staff', :with => '1500'
      fill_in 'organization_twitter', :with => 'caritas'
      fill_in 'organization_facebook', :with => 'www.facebook.com/caritas'
      fill_in 'organization_hq_address', :with => 'Peace St, 3'
      fill_in 'organization_contact_email', :with => 'caritas@exampe.com'
      fill_in 'organization_contact_phone_number', :with => '0031 111 11 11'
      fill_in 'organization_donation_address', :with => '(Donations) Peace St, 3'
      fill_in 'organization_zip_code', :with => '28005'
      fill_in 'organization_city', :with => 'New York'
      fill_in 'organization_state', :with => 'NY'
      fill_in 'organization_donation_phone_number', :with => '0031 111 11 12'
      fill_in 'organization_donation_website', :with => 'http://caritas.com/donations'
      click_link_or_button 'Save'
    end

    assert_equal 1, Organization.count
    caritas = Organization.last
    assert caritas.valid?

    page.should have_css("div.sidebar ul li", :text => 'Basic information')

    click_link_or_button "Media (0)"

    page.should have_css("h2", :text => 'Caritas')

    within(:xpath, "//div[@id='new_video']/form[@action='/admin/organizations/#{caritas.id}/media_resources']") do
      fill_in 'media_resource_vimeo_url', :with => 'http://vimeo.com/11144228'
      click_link_or_button 'save'
    end

    assert_equal 1, caritas.media_resources.count
    assert !caritas.media_resources.first.vimeo_url.blank?
    assert !caritas.media_resources.first.vimeo_embed_html.blank?

    page.should have_css("div.sidebar ul li", :text => 'Media (1)')

    click_link_or_button 'Delete'

    assert_equal 0, caritas.media_resources.count
    page.should have_css("div.sidebar ul li", :text => 'Media (0)')
  end

  scenario "Edit site specific information" do
    organization = create_organization
    site = create_site :project_context_organization_id => organization.id

    login_as_administrator

    click_link_or_button 'Manage Organizations'

    click_link_or_button organization.name

    page.should have_css("div.sidebar ul li ul li", :text => site.name)

    click_link_or_button site.name

    page.should have_css("h2", :text => "Edit information from #{organization.name} in site #{site.name}")

  end

end
