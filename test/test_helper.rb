ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

Dir["#{File.dirname(__FILE__)}/support/data/*.rb"].each {|f| require f}

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

require 'authenticated_test_helper'
include AuthenticatedTestHelper

class ActiveSupport::TestCase

  include Iom::Data
  include RR::Adapters::TestUnit

  def setup
    RR::Space.instance.reset
    DatabaseCleaner.clean
  end

  def teardown
    DatabaseCleaner.clean
  end

end