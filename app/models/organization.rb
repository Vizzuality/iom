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

  has_many :resources, :conditions => 'resources.element_type = #{Iom::ActsAsResource::ORGANIZATION_TYPE}', :foreign_key => :element_id, :dependent => :destroy
  has_many :media_resources, :conditions => 'media_resources.element_type = #{Iom::ActsAsResource::ORGANIZATION_TYPE}', :foreign_key => :element_id, :dependent => :destroy, :order => 'position ASC'
  has_many :projects, :foreign_key => :primary_organization_id

  has_attached_file :logo, :styles => {
                                      :small => {
                                        :geometry => "80x46>",
                                        :format => 'jpg'
                                      }
                                    },
                            :url => "/system/:attachment/:id/:style.:extension"

  has_many :sites, :foreign_key => :project_context_organization_id
  has_many :donations, :through => :projects

  validates_presence_of :name

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
  def projects_clusters_sectors(site)
    if site.navigate_by_cluster?
      sql="select c.id,c.name,count(ps.*) as count from clusters as c
      inner join clusters_projects as cp on c.id=cp.cluster_id
      inner join projects as p on p.id=cp.project_id and (p.end_date is null OR p.end_date > now())
      inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{site.id}
      where p.primary_organization_id=#{self.id}
      group by c.id,c.name order by count DESC"
      Cluster.find_by_sql(sql).map do |c|
        [c,c.count.to_i]
      end
    else
      sql="select s.id,s.name,count(ps.*) as count from sectors as s
      inner join projects_sectors as pjs on s.id=pjs.sector_id
      inner join projects as p on p.id=pjs.project_id and (p.end_date is null OR p.end_date > now())
      inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{site.id}
      where p.primary_organization_id=#{self.id}
      group by s.id,s.name order by count DESC"
      Sector.find_by_sql(sql).map do |s|
        [s,s.count.to_i]
      end
    end
  end

  # Array of arrays
  # [[region, count], [region, count]]
  def projects_regions(site)
    Region.find_by_sql(
<<-SQL
select r.id,r.name,count(ps.*) as count from regions as r
  inner join projects_regions as pr on r.id=pr.region_id
  inner join projects as p on p.id=pr.project_id and (p.end_date is null OR p.end_date > now())
  inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{site.id}
  where p.primary_organization_id=#{self.id}
        and r.level=#{site.level_for_region}
  group by r.id,r.name order by count DESC
SQL
    ).map do |r|
      [r, r.count.to_i]
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
    scoped.select("id,name").order("name ASC")
  end

  def projects_count(site)
    sql = "select count(p.id) as count from projects as p
    inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{site.id}
    where p.primary_organization_id=#{self.id} and (p.end_date is null OR p.end_date > now())"
    ActiveRecord::Base.connection.execute(sql).first['count'].to_i
  end

end
