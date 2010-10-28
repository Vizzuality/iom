# == Schema Information
#
# Table name: clusters
#
#  id         :integer         not null, primary key
#  name       :string(255)     
#  created_at :datetime        
#  updated_at :datetime        
#

class Cluster < ActiveRecord::Base
end
