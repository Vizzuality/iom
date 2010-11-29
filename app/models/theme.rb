# == Schema Information
#
# Table name: themes
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  css_file       :string(255)
#  thumbnail_path :string(255)
#

class Theme < ActiveRecord::Base

  has_many :sites

end
