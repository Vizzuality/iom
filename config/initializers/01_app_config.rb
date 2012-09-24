config_file_hash = YAML.load_file("#{Rails.root}/config/app_config.yml")
APP_CONFIG = config_file_hash[Rails.env]
