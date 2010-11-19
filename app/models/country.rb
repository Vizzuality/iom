# == Schema Information
#
# Table name: countries
#
#  id   :integer         not null, primary key
#  name :string(255)     
#  code :string(255)     
#

class Country < ActiveRecord::Base

  has_many :regions
  has_and_belongs_to_many :projects

end
