# == Schema Information
#
# Table name: organizations
#
#  id                        :integer         not null, primary key
#  name                      :string(255)     
#  description               :text            
#  budget                    :float           
#  website                   :string(255)     
#  staff                     :integer         
#  twitter                   :string(255)     
#  facebook                  :string(255)     
#  hq_address                :string(255)     
#  contact_email             :string(255)     
#  contact_phone_number      :string(255)     
#  donation_address          :string(255)     
#  zip_code                  :string(255)     
#  city                      :string(255)     
#  state                     :string(255)     
#  donation_phone_number     :string(255)     
#  donation_website          :string(255)     
#  site_specific_information :text            
#  created_at                :datetime        
#  updated_at                :datetime        
#  logo_file_name            :string(255)     
#  logo_content_type         :string(255)     
#  logo_file_size            :integer         
#  logo_updated_at           :datetime        
#  international_staff       :string(255)     
#  contact_name              :string(255)     
#  contact_position          :string(255)     
#  contact_zip               :string(255)     
#  contact_city              :string(255)     
#  contact_state             :string(255)     
#  contact_country           :string(255)     
#  donation_country          :string(255)     
#

class Organization < ActiveRecord::Base

  has_many :resources, :conditions => 'resources.element_type = #{Iom::ActsAsResource::ORGANIZATION_TYPE}', :foreign_key => :element_id, :dependent => :destroy
  has_many :media_resources, :conditions => 'media_resources.element_type = #{Iom::ActsAsResource::ORGANIZATION_TYPE}', :foreign_key => :element_id, :dependent => :destroy, :order => 'position ASC'
  has_many :projects, :foreign_key => :primary_organization_id
  has_attached_file :logo, :styles => { :small => "60x60#" }
  has_many :sites, :foreign_key => :project_context_organization_id
  has_many :donations, :through => :projects

  before_validation :clean_html

  validates_presence_of :name

  serialize :site_specific_information

  def attributes_for_site(site)
    atts = site_specific_information || {}
    atts[site.id.to_s]
  end

  def attributes_for_site=(value)
    atts = site_specific_information || {}
    atts[value[:site_id].to_s] = value[:organization_values]
    update_attribute(:site_specific_information, atts)
  end

  def donors_count
    donations.map{ |d| d.donor_id }.uniq.size
  end

  # Hash with the format:
  #  > { 'cluster_name' => [<array of project id's>] }
  def projects_clusters
    clusters = {}
    unless projects.empty?
      projects.each do |project|
        project.clusters.each do |cluster|
          clusters[cluster.name] ||= []
          clusters[cluster.name] << project.id
        end
      end
    end
    clusters
  end

  private

    def clean_html
      %W{ name description website twitter facebook hq_address contact_phone_number contact_email donation_address zip_code city state donation_phone_number donation_website }.each do |att|
        eval("self.#{att} = Sanitize.clean(self.#{att}.gsub(/\r/,'')) unless self.#{att}.blank?")
      end
    end

end
