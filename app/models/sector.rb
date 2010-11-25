# == Schema Information
#
# Table name: sectors
#
#  id   :integer         not null, primary key
#  name :string(255)     
#

class Sector < ActiveRecord::Base

  has_and_belongs_to_many :projects

end
