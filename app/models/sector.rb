# == Schema Information
#
# Table name: sectors
#
#  id   :integer         not null, primary key
#  name :string(255)
#

class Sector < ActiveRecord::Base

  has_and_belongs_to_many :projects

  def donors(site)
    sql="select distinct d.* from donors as d
    inner join donations as don on d.id=donor_id
    inner join projects_sectors as ps on don.project_id=ps.project_id and ps.sector_id=#{self.id}
    inner join projects_sites as ps on ps.project_id=don.project_id and ps.site_id=#{site.id}"
    Donor.find_by_sql(sql)
  end

  def self.custom_fields
    columns.map{ |c| c.name }
  end
  # Array of arrays
  # [[region, count], [region, count]]
  def projects_regions(site)
    Region.find_by_sql(
<<-SQL
  select #{Region.custom_fields.join(',')}, count(regions.id) as count
    from regions, projects_regions, projects_sectors where projects_sectors.sector_id = #{self.id} AND
    projects_sectors.project_id IN (#{site.projects_ids.join(',')}) AND
    projects_sectors.project_id = projects_regions.project_id AND
    projects_regions.region_id = regions.id AND
    regions.level = #{site.level_for_region}
    where regions.level=#{site.level_for_region}
    group by #{Region.custom_fields.join(',')}
SQL
    ).map do |r|
      [r, r.count.to_i]
    end
  end

  # to get only id and name
  def self.get_select_values
    scoped.select(:id,:name).order("name ASC")
  end

  def css_class
     if (name.include? 'Agriculture')
        'agriculture'
     elsif (name.include? 'Camp Coordination')
     'camp_coordination'
     elsif (name.include? 'Disaster')
     'disaster_management'
     elsif (name.include? 'Early Recovery')
     'early_recovery'
     elsif (name.include? 'Economic Recovery')
     'economic_recovery'
     elsif (name.include? 'Emergency Telecommunications')
     'emergency'
     elsif (name.include? 'Environment')
     'environment'
     elsif (name.include? 'Food Aid')
     'food_aid'
     elsif (name.include? 'Food Security')
     'food_security'
     elsif (name.include? 'Health')
     'health'
     elsif (name.include? 'Human')
     'human_rights'
     elsif (name.include? 'Logistics')
     'logistics'
     elsif (name.include? 'Nutrition')
     'nutrition'
     elsif (name.include? 'Peace & Security')
      'peace_security'
     elsif (name.include? 'Protection')
       'protection'
     elsif (name.include? 'Shelter & Housing')
        'shelter'
     elsif (name.include? 'Water, Sanitation')
        'water_sanitation'
     else
        'other'
     end
   end
end
