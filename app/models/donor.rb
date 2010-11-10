# == Schema Information
#
# Table name: donors
#
#  id                        :integer         not null, primary key
#  name                      :string(255)     
#  description               :text            
#  website                   :string(255)     
#  twitter                   :string(255)     
#  facebook                  :string(255)     
#  contact_person_name       :string(255)     
#  contact_company           :string(255)     
#  contact_person_position   :string(255)     
#  contact_email             :string(255)     
#  contact_phone_number      :string(255)     
#  logo_file_name            :string(255)     
#  logo_content_type         :string(255)     
#  logo_file_size            :integer         
#  logo_updated_at           :datetime        
#  site_specific_information :text            
#  created_at                :datetime        
#  updated_at                :datetime        
#

class Donor < ActiveRecord::Base

  before_validation :clean_html

  validates_presence_of :name

  has_attached_file :logo, :styles => { :small => "60x60#" }

  private

    def clean_html
      %W{ name description website twitter facebook contact_person_name contact_company contact_person_position contact_email contact_phone_number }.each do |att|
        eval("self.#{att} = Sanitize.clean(self.#{att}.gsub(/\r/,'')) unless self.#{att}.blank?")
      end
    end

end
