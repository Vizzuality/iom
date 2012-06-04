# config/initializers/rack_middlewares.rb
#
# This initializer configures Rack middlewares and loads custom middlewares.

require File.join(Rails.root, 'lib', 'google_bot_aware')

Iom::Application.configure do
  config.middleware.use("GoogleBotAware")
end
