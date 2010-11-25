# == Schema Information
#
# Table name: regions
#
#  id         :integer         not null, primary key
#  name       :string(255)     
#  country_id :integer         
#

class Region < ActiveRecord::Base

  belongs_to :country
  has_and_belongs_to_many :projects

end
