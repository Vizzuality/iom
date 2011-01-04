require File.dirname(__FILE__) + "/../spec_helper"
require "steak"
require 'capybara/rails'
require "capybara/dsl"
require "selenium-webdriver"

Capybara.default_driver    = :rack_test
Capybara.default_host      = 'example.com'
Capybara.server_port       = 9887
Capybara.app_host          = "http://#{Capybara.default_host}:#{Capybara.server_port}"
Capybara.default_wait_time = 10

RSpec.configuration.include Capybara, :type => :acceptance

# load spec/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
# load test/support
Dir["#{File.dirname(__FILE__)}/../../test/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include Iom::Data
  config.include Capybara, :type => :acceptance

  config.before(:each) do
    Rails.cache.clear
    RR::Space.instance.reset
    # any_instance_of(Action, :save_attached_files => true)
    # any_instance_of(Action, :delete_attached_files => true)
    # any_instance_of(User) do |u|
    #    stub(u).save_attached_files {true}
    #    stub(u).delete_attached_files {true}
    #  end
    any_instance_of(Paperclip::Attachment, :post_process => true)
    Capybara.current_driver = :selenium
  end

  config.after(:each) do
    case page.driver.class
    when Capybara::Driver::RackTest
      page.driver.rack_mock_session.clear_cookies
    when Capybara::Driver::Culerity
      page.driver.browser.clear_cookies
    when Capybara::Driver::Selenium
      page.driver.cleanup!
    end
    Capybara.use_default_driver
  end

end
