require File.dirname(__FILE__) + "/../spec_helper"
require "steak"
require 'capybara/rails'
require "capybara/rails"
require "capybara/dsl"
require 'database_cleaner'
require "selenium-webdriver"

DatabaseCleaner.strategy = :transaction
Capybara.default_driver = :rack_test
Capybara.default_host = 'www.example.com'
Capybara.app_host = 'http://www.example.com:9887'
Capybara.default_wait_time = 5

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
    DatabaseCleaner.start
    RR::Space.instance.reset
    Capybara.reset_sessions!
    # any_instance_of(Action, :save_attached_files => true)
    # any_instance_of(Action, :delete_attached_files => true)
    # any_instance_of(User) do |u|
    #    stub(u).save_attached_files {true}
    #    stub(u).delete_attached_files {true}
    #  end
    any_instance_of(Paperclip::Attachment, :post_process => true)
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
    DatabaseCleaner.clean
  end

end
