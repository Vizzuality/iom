# == Schema Information
#
# Table name: organizations
#
#  id                              :integer         not null, primary key
#  name                            :string(255)
#  description                     :text
#  budget                          :float
#  website                         :string(255)
#  national_staff                  :integer
#  twitter                         :string(255)
#  facebook                        :string(255)
#  hq_address                      :string(255)
#  contact_email                   :string(255)
#  contact_phone_number            :string(255)
#  donation_address                :string(255)
#  zip_code                        :string(255)
#  city                            :string(255)
#  state                           :string(255)
#  donation_phone_number           :string(255)
#  donation_website                :string(255)
#  site_specific_information       :text
#  created_at                      :datetime
#  updated_at                      :datetime
#  logo_file_name                  :string(255)
#  logo_content_type               :string(255)
#  logo_file_size                  :integer
#  logo_updated_at                 :datetime
#  international_staff             :string(255)
#  contact_name                    :string(255)
#  contact_position                :string(255)
#  contact_zip                     :string(255)
#  contact_city                    :string(255)
#  contact_state                   :string(255)
#  contact_country                 :string(255)
#  donation_country                :string(255)
#  estimated_people_reached        :integer
#  private_funding                 :float
#  usg_funding                     :float
#  other_funding                   :float
#  private_funding_spent           :float
#  usg_funding_spent               :float
#  other_funding_spent             :float
#  spent_funding_on_relief         :float
#  spent_funding_on_reconstruction :float
#  percen_relief                   :integer
#  percen_reconstruction           :integer
#  media_contact_name              :string(255)
#  media_contact_position          :string(255)
#  media_contact_phone_number      :string(255)
#  media_contact_email             :string(255)
#

class Organization < ActiveRecord::Base

  has_many :resources, :conditions => 'resources.element_type = #{Iom::ActsAsResource::ORGANIZATION_TYPE}', :foreign_key => :element_id, :dependent => :destroy do
    # Filter specific resources from a site
    def site(site)
      self.select{ |r| r.sites_ids.include?(site.id.to_s) }
    end
  end
  has_many :media_resources, :conditions => 'media_resources.element_type = #{Iom::ActsAsResource::ORGANIZATION_TYPE}', :foreign_key => :element_id, :dependent => :destroy, :order => 'position ASC'
  has_many :projects, :foreign_key => :primary_organization_id do
    # Filter specific projects from a site
    def site(site)
      self.where("projects.id IN (#{site.projects_ids.join(',')})")
    end
  end

  has_attached_file :logo, :styles => {
                                      :small => {
                                        :geometry => "80x46#",
                                        :quality => 90,
                                        :format => 'jpg'
                                      }
                                    },
                            :url => "/system/:attachment/:id/:style.:extension"

  has_many :sites, :foreign_key => :project_context_organization_id
  has_many :donations, :through => :projects

  validates_presence_of :name
  #validates_presence_of :description

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
      [Region.find(row['region_id'], :select => Region.custom_fields), row['count'].to_i]
    end
  end

  def projects_file=(file)
    return if file.blank?
    projects_ids_to_delete = self.project_ids || []

    csv_projects = []

    CsvMapper.import(file, :type => :io) do
      map_to Project
      after_row lambda{ |row, project|
        csv_projects << project
      }

      start_at_row 1
      read_attributes_from_file
    end

    Project.delete(projects_ids_to_delete - csv_projects.map{|p| p.id})

    organization = self
    csv_projects.each do |project|
      if organization.projects.exists? :id => project.id
        project.primary_organization = organization
        organization.projects.find(project.id).update_attributes project.attributes
      else
        organization.projects << project
      end
    end
  end

  # to get only id and name
  def self.get_select_values
    scoped.select(:id,:name).order("name ASC")
  end

end
