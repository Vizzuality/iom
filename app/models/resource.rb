# == Schema Information
#
# Table name: resources
#
#  id           :integer         not null, primary key
#  title        :string(255)     
#  url          :string(255)     
#  element_id   :integer         
#  element_type :integer         
#  created_at   :datetime        
#  updated_at   :datetime        
#

class Resource < ActiveRecord::Base
end
