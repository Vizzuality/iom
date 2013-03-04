# == Schema Information
#
# Table name: media_resources
#
#  id                       :integer         not null, primary key
#  position                 :integer         default(0)
#  element_id               :integer
#  element_type             :integer
#  picture_file_name        :string(255)
#  picture_content_type     :string(255)
#  picture_filesize         :integer
#  picture_updated_at       :datetime
#  video_url                :string(255)
#  video_embed_html         :text
#  created_at               :datetime
#  updated_at               :datetime
#  caption                  :string(255)
#  video_thumb_file_name    :string(255)
#  video_thumb_content_type :string(255)
#  video_thumb_file_size    :integer
#  video_thumb_updated_at   :datetime
#

class MediaResource < ActiveRecord::Base

  acts_as_resource

  has_attached_file :picture, :styles => {
                                      :small => {
                                        :geometry => "80x46#",
                                        :format => 'jpg'
                                      },
                                      :medium => {
                                        :geometry => "660x400#",
                                        :format => 'jpg'
                                      }
                                    },
                            :convert_options => {
                              :all => "-quality 90"
                            },
                            :url => "/system/:attachment/:id/:style.:extension"

  has_attached_file :video_thumb, :styles => {
                                      :medium => {
                                        :geometry => "660x400#",
                                        :format => 'jpg'
                                      }
                                    },
                            :convert_options => {
                              :all => "-quality 90"
                            },
                            :url => "/system/:attachment/:id/:style.:extension"

  before_create :set_position

  validate :presence_of_picture_or_attachment

  def is_a_video?
    video_url?
  end

  def video_url=(value)
    video_metadata = VideoProvider.get(value)
    write_attribute(:video_url, value)
    write_attribute(:video_embed_html, video_metadata.html)
    self.video_thumb = open(video_metadata.thumbnail_url)
  rescue URI::InvalidURIError
    errors[:base] << "You have to upload a picture or indicate a video URL"
  end

  # decrement position
  def move_up
    return if self.position == 0
    return if self.class.count == 1
    upper_resource = self.class.where(["element_id = ? AND element_type = ? AND position < ?", element_id, element_type, position]).order('position DESC').first
    old_position = self.position
    self.position = upper_resource.position
    upper_resource.position = old_position
    upper_resource.save
  end

  # increment position
  def move_down
    return if self.class.count == 1
    if lower_resource = self.class.where(["element_id = ? AND element_type = ? AND position > ?", element_id, element_type, position]).order('position ASC').first
      old_position = self.position
      self.position = lower_resource.position
      lower_resource.position = old_position
      lower_resource.save
    end
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

    def presence_of_picture_or_attachment
      if video_url.blank? && picture_file_name.blank?
        errors[:base] << "You have to upload a picture or indicate a video URL"
      end
    end

end
