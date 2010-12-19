module HelperMethods
  def login_as_administrator
    create_user
    visit '/login'
    within(:xpath, "//form[@action='/session']") do
      fill_in 'email', :with => default_user_attributes[:email]
      fill_in 'password', :with => default_user_attributes[:password]
      click_link_or_button 'Sign in'
    end
    page.should have_css("a", :text => 'close session', :href => '/logout')
  end

  def reset_pk_sequence(table_name)
    ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
  end

  def peich
    save_and_open_page
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
