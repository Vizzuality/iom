# == Schema Information
#
# Table name: media_resources
#
#  id                   :integer         not null, primary key
#  position             :integer         default(0)
#  element_id           :integer
#  element_type         :integer
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_filesize     :integer
#  picture_updated_at   :datetime
#  vimeo_url            :string(255)
#  vimeo_embed_html     :text
#  created_at           :datetime
#  updated_at           :datetime
#

class MediaResource < ActiveRecord::Base

  acts_as_resource

  has_attached_file :picture, :styles => { :small => "60x60#", :medium => "300x300#" }

  before_create :set_position

  def is_a_video?
    vimeo_url?
  end

  # http://vimeo.com/api/oembed.xml?url=http://vimeo.com/7100569
  def vimeo_url=(value)
    response = open("http://vimeo.com/api/oembed.xml?url=#{value}").read
    match = response.match(/<html>([^<]+)<\/html>/)
    write_attribute(:vimeo_url, value)
    write_attribute(:vimeo_embed_html, match[1])
  end

  private

    def set_position
      return if self.class.count == 0
      if last_resource_from_element = self.class.select("max(position) as position").where(:element_id => self.element_id, :element_type => self.element_type).first.position
        self.position = last_resource_from_element + 1
      else
        self.position = 0
      end
    end

end
