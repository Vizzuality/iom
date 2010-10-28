# == Schema Information
#
# Table name: ngos
#
#  id                      :integer         not null, primary key
#  name                    :string(255)     
#  description             :text            
#  website                 :string(255)     
#  contact_person_name     :string(255)     
#  contact_person_position :string(255)     
#  contact_email           :string(255)     
#  contact_phone_number    :string(255)     
#  donation_address        :text            
#  donation_city           :string(255)     
#  donation_state          :string(255)     
#  zip_code                :string(255)     
#  donation_phone_number   :string(255)     
#  donation_webiste        :string(255)     
#  created_at              :datetime        
#  updated_at              :datetime        
#

class Ngo < ActiveRecord::Base
end
