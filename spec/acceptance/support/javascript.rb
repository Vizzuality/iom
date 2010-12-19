# Adapted for Rspec2. This won't work in RSpec 1.
# Put this code in acceptance_helper.rb or better in a new file spec/acceptance/support/javascript.rb

Rspec.configure do |config|

  config.before(:each) do
    Capybara.current_driver = :selenium if example.metadata[:js]
  end

  config.after(:each) do
    Capybara.use_default_driver if example.metadata[:js]
  end

end