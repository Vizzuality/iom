require File.dirname(__FILE__) + '/acceptance_helper'

feature "Projects" do

  scenario "Create and update a project" do
    organization = create_organization :name => 'Intermon'
    spain = create_country :name => 'Spain'
    food = create_cluster :name => 'food'
    haiti = create_sector :name => 'haiti'

    login_as_administrator

    click_link_or_button 'Manage Projects'
    click_link_or_button '+ new project'

    page.should have_css("h2", :text => 'New project')

    within(:xpath, "//form[@action='/admin/projects']") do
      fill_in 'project_name', :with => 'Food Security'
      fill_in 'project_description', :with => 'Food Security Description'
      fill_in 'project_tags', :with => 'food, security, haiti'
      select  'Intermon', :from => 'project_primary_organization_id'
      fill_in 'project_budget', :with => 200
      fill_in 'project_target', :with => 'farmers'
      fill_in 'project_estimated_people_reached', :with => 1230
      fill_in 'project_contact_email', :with => 'contact@example.com'
      fill_in 'project_contact_person', :with => 'Food Security contact'
      fill_in 'project_contact_phone_number', :with => '0031 500 400 300'
      click_link_or_button 'Save'
    end

    project = Project.last
    assert project.valid?
    assert_equal 'Food Security', project.name
    assert_equal 3, project.tags.count

    page.should have_css("h2", :text => 'Edit project Food Security')
    page.should have_css("div.sidebar ul li", :text => 'Basic information')

    click_link_or_button "Media (0)"

    page.should have_css("h2", :text => 'Food Security')

    within(:xpath, "//form[@action='/admin/projects/#{project.id}/media_resources']") do
      attach_file('media_resource_picture', "#{Rails.root}/test/support/images/blatsoft.jpg")
      click_link_or_button 'save'
    end

    assert_equal 1, project.media_resources.count

    page.should have_css("div.sidebar ul li", :text => 'Media (1)')

    click_link_or_button 'Delete'

    assert_equal 0, project.media_resources.count
    page.should have_css("div.sidebar ul li", :text => 'Media (0)')

    click_link_or_button "Resources (0)"

    page.should have_css("p", :text => '0 resources')

    within(:xpath, "//form[@action='/admin/projects/#{project.id}/resources']") do
      fill_in 'resource_title', :with => 'PDF Report'
      fill_in 'resource_url',   :with => 'http://www.report.com/report.pdf'
      click_link_or_button 'add resource'
    end

    assert_equal 1, project.resources.count
    assert_equal 'PDF Report', project.resources.first.title
    assert_equal 'http://www.report.com/report.pdf', project.resources.first.url

    page.should have_css("div.sidebar ul li", :text => 'Resources (1)')

    click_link_or_button 'Delete'

    assert_equal 0, project.resources.count
    page.should have_css("div.sidebar ul li", :text => 'Resources (0)')
  end

end
