# == Schema Information
#
# Table name: sites
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  short_description :text
#  long_description  :text
#  contact_email     :string(255)
#  contact_person    :string(255)
#  url               :string(255)
#  permalink         :string(255)
#  has_blog          :boolean
#  created_at        :datetime
#  updated_at        :datetime
#  the_geom          :geometry
#

class Site < ActiveRecord::Base

  before_validation :clean_html

  private

    def clean_html
      %W{ name short_description long_description contact_person contact_email url permalink }.each do |att|
        eval("self.#{att} = Sanitize.clean(self.#{att}.gsub(/\r/,'')) unless self.#{att}.blank?")
      end
    end

end
