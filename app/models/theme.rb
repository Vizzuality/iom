# == Schema Information
#
# Table name: themes
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  css_file       :string(255)
#  thumbnail_path :string(255)
#  data           :text
#

class Theme < ActiveRecord::Base

  has_many :sites

  serialize :data, Hash

  # :data contains a hash of serialized key and values
  # To add a key, value:
  #  - theme.data[:my_attribute] = 'myvalue'
  #  - theme.save
  # To fetch the value:
  #  - theme.data[:my_attribute]
  def data
    self[:data] ||= HashWithIndifferentAccess.new
  end

end
