require 'rollbar/rails'

Rollbar.configure do |config |
  config.access_token = APP_CONFIG['rollbar_token']
end
