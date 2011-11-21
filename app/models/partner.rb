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

  has_attached_file :logo, :styles => {
                                      :small => {
                                        :geometry => '80x46>',
                                        :format => 'jpg'
                                      }
                                    },
                            :url => "/system/:attachment/:id/:style.:extension"

  validates_presence_of :name, :url, :label, :logo

  def url=(partner_url)
    write_attribute('url', partner_url.add_protocol_if_required!)
  end
end
