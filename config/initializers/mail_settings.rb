if Rails.env.production?
Iom::Application.configure do
  config.action_mailer.smtp_settings = {
    :address              => APP_CONFIG['smtp_address'],
    :port                 => APP_CONFIG['smtp_port'],
    :user_name            => APP_CONFIG['smtp_user_name'],
    :password             => APP_CONFIG['smtp_password'],
    :authentication       => 'plain' }
end
end
