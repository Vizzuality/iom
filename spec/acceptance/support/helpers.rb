module HelperMethods
  def login_as_administrator
    create_user
    visit '/login'
    within(:xpath, "//form[@action='/session']") do
      fill_in 'email', :with => default_user_attributes[:email]
      fill_in 'password', :with => default_user_attributes[:password]
      click_link_or_button 'Log in'
    end
    page.should have_css("a", :text => 'logout', :href => '/logout')
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
