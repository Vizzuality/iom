require File.dirname(__FILE__) + '/acceptance_helper'

feature "Donors" do

  scenario "Create and update an donor" do
    login_as_administrator

    click_link_or_button 'Manage Donors'

    click_link_or_button '+ new donor'

    within(:xpath, "//form[@action='/admin/donors']") do
      fill_in 'donor_name', :with => 'Fernando Blat'
      fill_in 'donor_description', :with => 'Fernando Blat is a non-profit donor'
      attach_file('donor_logo', "#{Rails.root}/test/support/images/blatsoft.jpg")
      fill_in 'donor_website', :with => 'http://blat.org/donors'
      fill_in 'donor_twitter', :with => 'blatsfot'
      fill_in 'donor_facebook', :with => 'www.facebook.com/blatsfot'
      fill_in 'donor_contact_person_name', :with => 'Fernando Blat'
      fill_in 'donor_contact_company', :with => 'Blat Soft'
      fill_in 'donor_contact_person_position', :with => 'BlatSoft CTO'
      fill_in 'donor_contact_email', :with => 'blatsoft@exampe.com'
      fill_in 'donor_contact_phone_number', :with => '0031 111 11 11'
      click_link_or_button 'Save'
    end

    assert_equal 1, Donor.count
    blatsoft = Donor.last
    assert blatsoft.valid?

    page.should have_css("h2", :text => "Edit donor Fernando Blat")

    visit "/admin/donors"

    page.should have_css("h2", :text => "Donors")

    click_link_or_button "Fernando Blat"

    page.should have_css("h2", :text => "Edit donor Fernando Blat")

    within(:xpath, "//form[@action='/admin/donors/#{blatsoft.id}']") do
      fill_in 'donor_contact_email', :with => 'blatsoft@example.com'
      click_link_or_button 'Save'
    end

    page.should have_css("h2", :text => "Edit donor Fernando Blat")

    blatsoft.reload

    assert_equal 'blatsoft@example.com', blatsoft.contact_email

    click_link_or_button 'Delete this donor'

    page.should have_css("h2", :text => "Donors")

    assert_nil Donor.find_by_id(blatsoft.id)

  end

  scenario "Donor resources" do

    login_as_administrator

    click_link_or_button 'Manage Donors'

    click_link_or_button '+ new donor'

    within(:xpath, "//form[@action='/admin/donors']") do
      fill_in 'donor_name', :with => 'Fernando Blat'
      fill_in 'donor_description', :with => 'Fernando Blat is a non-profit donor'
      attach_file('donor_logo', "#{Rails.root}/test/support/images/blatsoft.jpg")
      fill_in 'donor_website', :with => 'http://blat.org/donors'
      fill_in 'donor_twitter', :with => 'blatsfot'
      fill_in 'donor_facebook', :with => 'www.facebook.com/blatsfot'
      fill_in 'donor_contact_person_name', :with => 'Fernando Blat'
      fill_in 'donor_contact_company', :with => 'Blat Soft'
      fill_in 'donor_contact_person_position', :with => 'BlatSoft CTO'
      fill_in 'donor_contact_email', :with => 'blatsoft@exampe.com'
      fill_in 'donor_contact_phone_number', :with => '0031 111 11 11'
      click_link_or_button 'Save'
    end

    assert_equal 1, Donor.count
    blatsoft = Donor.last
    assert blatsoft.valid?

    page.should have_css("h2", :text => "Edit donor Fernando Blat")

    page.should have_css("div.sidebar ul li", :text => 'Basic information')

    click_link_or_button "Resources (0)"

    page.should have_css("h2", :text => 'Fernando Blat')
    page.should have_css("p", :text => '0 resources')

    within(:xpath, "//form[@action='/admin/donors/#{blatsoft.id}/resources']") do
      fill_in 'resource_title', :with => 'PDF Report'
      fill_in 'resource_url',   :with => 'http://www.report.com/report.pdf'
      click_link_or_button 'add resource'
    end

    assert_equal 1, blatsoft.resources.count
    assert_equal 'PDF Report', blatsoft.resources.first.title
    assert_equal 'http://www.report.com/report.pdf', blatsoft.resources.first.url

    page.should have_css("div.sidebar ul li", :text => 'Resources (1)')

    click_link_or_button 'Delete'

    assert_equal 0, blatsoft.resources.count
    page.should have_css("div.sidebar ul li", :text => 'Resources (0)')

  end

  scenario "Donor media resources" do

    login_as_administrator

    click_link_or_button 'Manage Donors'

    click_link_or_button '+ new donor'

    within(:xpath, "//form[@action='/admin/donors']") do
      fill_in 'donor_name', :with => 'Fernando Blat'
      fill_in 'donor_description', :with => 'Fernando Blat is a non-profit donor'
      attach_file('donor_logo', "#{Rails.root}/test/support/images/blatsoft.jpg")
      fill_in 'donor_website', :with => 'http://blat.org/donors'
      fill_in 'donor_twitter', :with => 'blatsfot'
      fill_in 'donor_facebook', :with => 'www.facebook.com/blatsfot'
      fill_in 'donor_contact_person_name', :with => 'Fernando Blat'
      fill_in 'donor_contact_company', :with => 'Blat Soft'
      fill_in 'donor_contact_person_position', :with => 'BlatSoft CTO'
      fill_in 'donor_contact_email', :with => 'blatsoft@exampe.com'
      fill_in 'donor_contact_phone_number', :with => '0031 111 11 11'
      click_link_or_button 'Save'
    end

    assert_equal 1, Donor.count
    blatsoft = Donor.last
    assert blatsoft.valid?

    page.should have_css("h2", :text => "Edit donor Fernando Blat")

    page.should have_css("div.sidebar ul li", :text => 'Basic information')

    click_link_or_button "Media (0)"

    page.should have_css("h2", :text => 'Fernando Blat')

    within(:xpath, "//form[@action='/admin/donors/#{blatsoft.id}/media_resources']") do
      attach_file('media_resource_picture', "#{Rails.root}/test/support/images/blatsoft.jpg")
      click_link_or_button 'save'
    end

    assert_equal 1, blatsoft.media_resources.count

    page.should have_css("div.sidebar ul li", :text => 'Media (1)')

    click_link_or_button 'Delete'

    assert_equal 0, blatsoft.media_resources.count
    page.should have_css("div.sidebar ul li", :text => 'Media (0)')
  end

end