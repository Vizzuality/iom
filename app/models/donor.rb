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

  has_many :resources, :conditions => 'resources.element_type = #{Iom::ActsAsResource::DONOR_TYPE}', :foreign_key => :element_id, :dependent => :destroy
  has_many :media_resources, :conditions => 'media_resources.element_type = #{Iom::ActsAsResource::DONOR_TYPE}', :foreign_key => :element_id, :dependent => :destroy, :order => 'position ASC'

  has_many :donations
  has_many :donated_projects, :through => :donations, :source => :project

  has_attached_file :logo, :styles => { :small => "60x60#" }

  before_validation :clean_html

  validates_presence_of :name

  def donations_amount
    donations.inject(0){ |result, donation| result + donation.amount }
  end

  private

    def clean_html
      %W{ name description website twitter facebook contact_person_name contact_company contact_person_position contact_email contact_phone_number }.each do |att|
        eval("self.#{att} = Sanitize.clean(self.#{att}.gsub(/\r/,'')) unless self.#{att}.blank?")
      end
    end

end
