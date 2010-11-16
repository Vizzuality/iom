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

  acts_as_resource

  validates_presence_of   :title, :url, :element_type, :element_id
  validates_uniqueness_of :title, :scope => [:element_type, :element_id]
  validates_uniqueness_of :url,   :scope => [:element_type, :element_id]

end
