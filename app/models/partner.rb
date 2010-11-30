# == Schema Information
#
# Table name: partners
#
#  id                :integer         not null, primary key
#  site_id           :integer
#  name              :string(255)
#  url               :string(255)
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  created_at        :datetime
#  updated_at        :datetime
#

class Partner < ActiveRecord::Base

  belongs_to :site
  has_attached_file :logo, :styles => { :small => "60x60#" }

  validates_presence_of :name

end
