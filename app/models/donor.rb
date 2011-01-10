# == Schema Information
#
# Table name: donors
#
#  id                        :integer         not null, primary key
#  name                      :string(2000)    
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
  has_many :donated_projects, :through => :donations, :source => :project, :uniq => true, :conditions => "(projects.end_date is null or projects.end_date > now())"

  has_attached_file :logo, :styles => {
                                      :small => {
                                        :geometry => "80x46>",
                                        :format => 'jpg'
                                      }
                                    },
                            :url => "/system/:attachment/:id/:style.:extension"

  before_validation :clean_html

  validates_presence_of :name

  def donations_amount
    donations.inject(0){
      |result, donation|
      if (!donation.amount.nil?)
        result + donation.amount
      else
        result + 0
      end
    }
  end

  # Array of arrays
  # [[category, count], [category, count]]
  def projects_sectors_or_clusters(site)
    if site.navigate_by_sector?
      sql="select s.id,s.name,count(ps.*) as count from sectors as s
      inner join projects_sectors as ps on s.id=ps.sector_id
      inner join projects_sites as psi on ps.project_id=psi.project_id and psi.site_id=#{site.id}
      inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
      inner join donations as d on psi.project_id=d.project_id and d.donor_id=#{self.id}
      group by s.id,s.name order by count DESC"
      Sector.find_by_sql(sql).map do |s|
        [s,s.count.to_i]
      end
    else
      sql="select c.id,c.name,count(ps.*) as count from clusters as c
      inner join clusters_projects as cp on c.id=cp.cluster_id
      inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=#{site.id}
      inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
      inner join donations as d on ps.project_id=d.project_id and d.donor_id=#{self.id}
      group by c.id,c.name order by count DESC"
      Cluster.find_by_sql(sql).map do |c|
        [c,c.count.to_i]
      end
    end
  end

  # Array of arrays
  # [[cluster, count], [cluster, count]]
  def projects_regions(site)
    Region.find_by_sql(
<<-SQL
  select r.id,r.name,r.level,r.parent_region_id, r.country_id,count(ps.*) as count from regions as r
    inner join projects_regions as pr on r.id=pr.region_id
    inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{site.id}
    inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
    inner join donations as d on ps.project_id=d.project_id and d.donor_id=#{self.id}
    where r.level=#{site.level_for_region}
    group by r.id,r.name,r.level,r.parent_region_id, r.country_id order by count DESC
SQL
    ).map do |r|
      [r, r.count.to_i]
    end
  end

  serialize :site_specific_information

  # Attributes for site getter
  def attributes_for_site(site)
    atts = site_specific_information || {}
    atts[site.id.to_s]
  end

  # Attributes for site setter
  def attributes_for_site=(value)
    atts = site_specific_information || {}
    atts[value[:site_id].to_s] = value[:donor_values]
    update_attribute(:site_specific_information, atts)
  end

  private

    def clean_html
      %W{ name description website twitter facebook contact_person_name contact_company contact_person_position contact_email contact_phone_number }.each do |att|
        eval("self.#{att} = Sanitize.clean(self.#{att}.gsub(/\r/,'')) unless self.#{att}.blank?")
      end
    end

end
