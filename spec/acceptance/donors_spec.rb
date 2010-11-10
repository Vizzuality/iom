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

    page.should have_css("h1", :text => "Edit donor Fernando Blat")

    visit "/admin/donors"

    page.should have_css("h1", :text => "Donors")

    click_link_or_button "Fernando Blat"

    page.should have_css("h1", :text => "Edit donor Fernando Blat")

    within(:xpath, "//form[@action='/admin/donors/#{blatsoft.id}']") do
      fill_in 'donor_contact_email', :with => 'blatsoft@example.com'
      click_link_or_button 'Save'
    end

    page.should have_css("h1", :text => "Edit donor Fernando Blat")

    blatsoft.reload

    assert_equal 'blatsoft@example.com', blatsoft.contact_email

    click_link_or_button 'Delete this donor'

    page.should have_css("h1", :text => "Donors")

    assert_nil Donor.find_by_id(blatsoft.id)

  end
end
