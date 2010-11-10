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

    page.should have_css("h1", :text => "Edit organization Caritas")

    visit "/admin/organizations"

    page.should have_css("h1", :text => "Organizations")

    click_link_or_button "Caritas"

    page.should have_css("h1", :text => "Edit organization Caritas")

    within(:xpath, "//form[@action='/admin/organizations/#{caritas.id}']") do
      fill_in 'organization_budget', :with => '200001'
      click_link_or_button 'Save'
    end

    page.should have_css("h1", :text => "Edit organization Caritas")

    caritas.reload

    assert_equal 200001, caritas.budget

    click_link_or_button 'Delete this NGO'

    page.should have_css("h1", :text => "Organizations")

    assert_nil Organization.find_by_id(caritas.id)

  end
end
