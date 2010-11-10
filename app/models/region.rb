# == Schema Information
#
# Table name: regions
#
#  id         :integer         not null, primary key
#  country_id :integer         
#  name       :string(255)     
#

class Region < ActiveRecord::Base

  belongs_to :country

end
