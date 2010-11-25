# == Schema Information
#
# Table name: settings
#
#  id                        :integer         not null, primary key
#  default_email             :string(255)     
#  default_contact_name      :string(255)     
#  geoiq_parameter_1         :string(255)     
#  geoiq_parameter_2         :string(255)     
#  google_analytics_username :string(255)     
#  google_analytics_password :string(255)     
#

class Settings < ActiveRecord::Base
end
