# == Schema Information
#
# Table name: donors
#
#  id                      :integer         not null, primary key
#  name                    :string(255)     
#  description             :text            
#  contact_person_name     :string(255)     
#  contact_person_position :string(255)     
#  contact_email           :string(255)     
#  contact_number          :string(255)     
#  created_at              :datetime        
#  updated_at              :datetime        
#

class Donor < ActiveRecord::Base
end
