require 'database_cleaner'

RSpec.configure do |config|

  DatabaseCleaner.strategy = :truncation

  config.before :each do
    Capybara.reset_sessions!
    DatabaseCleaner.clean
  end

end