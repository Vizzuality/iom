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

  has_many :resources, :conditions => 'resources.element_type = #{Iom::ActsAsResource::ORGANIZATION_TYPE}', :foreign_key => :element_id, :dependent => :destroy do
    def site(site)
      self.select{ |r| r.sites_ids.include?(site.id.to_s) }
    end
  end
  has_many :media_resources, :conditions => 'media_resources.element_type = #{Iom::ActsAsResource::ORGANIZATION_TYPE}', :foreign_key => :element_id, :dependent => :destroy, :order => 'position ASC'
  has_many :projects, :foreign_key => :primary_organization_id do
    def site(site)
      self.where("projects.id IN (#{site.projects_ids.join(',')})")
    end
  end
  has_attached_file :logo, :styles => { :small => "60x60#" }
  has_many :sites, :foreign_key => :project_context_organization_id
  has_many :donations, :through => :projects

  before_validation :clean_html

  validates_presence_of :name
  validates_presence_of :description

  serialize :site_specific_information

  # Attributes for site getter
  def attributes_for_site(site)
    atts = site_specific_information || {}
    atts[site.id.to_s]
  end

  # Attributes for site setter
  def attributes_for_site=(value)
    atts = site_specific_information || {}
    atts[value[:site_id].to_s] = value[:organization_values]
    update_attribute(:site_specific_information, atts)
  end

  def donors_count
    @donors_count ||= donations.map{ |d| d.donor_id }.uniq.size
  end

  # Array of arrays
  # [[cluster, count], [cluster, count]]
  def projects_clusters(site)
    result = ActiveRecord::Base.connection.execute("select cluster_id, count(cluster_id) as count from clusters_projects where project_id IN (select id from projects where primary_organization_id=#{self.id}) AND project_id IN (#{site.projects_ids.join(',')}) group by cluster_id order by count desc")
    result.map do |row|
      [Cluster.find(row['cluster_id']), row['count'].to_i]
    end
  end

  # Array of arrays
  # [[region, count], [region, count]]
  def projects_regions(site)
    result = ActiveRecord::Base.connection.execute("select region_id, count(region_id) as count from projects_regions where project_id IN (select id from projects where primary_organization_id=#{self.id}) AND project_id IN (#{site.projects_ids.join(',')}) group by region_id order by count desc")
    result.map do |row|
      [Region.find(row['region_id']), row['count'].to_i]
    end
  end

  private

    def clean_html
      %W{ name description website twitter facebook hq_address contact_phone_number contact_email donation_address zip_code city state donation_phone_number donation_website }.each do |att|
        eval("self.#{att} = Sanitize.clean(self.#{att}.gsub(/\r/,'')) unless self.#{att}.blank?")
      end
    end

end
