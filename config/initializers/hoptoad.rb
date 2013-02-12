if Rails.env.production?
  HoptoadNotifier.configure do |config|
    config.api_key = 'fbcef44ba53e037bbf994f8f95737af4'
  end
end
