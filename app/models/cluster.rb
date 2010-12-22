# == Schema Information
#
# Table name: clusters
#
#  id   :integer         not null, primary key
#  name :string(255)
#

class Cluster < ActiveRecord::Base

  has_and_belongs_to_many :projects

  def donors(site)
    (projects & site.projects).map do |project|
      project.donors
    end.flatten.uniq
  end

  def self.custom_fields
    columns.map{ |c| c.name }
  end

  # Array of arrays
  # [[region, count], [region, count]]
  def projects_regions(site)
    result = ActiveRecord::Base.connection.execute("select region_id, count(region_id) as count from projects_regions where project_id IN (select project_id from clusters_projects where cluster_id=#{self.id}) AND project_id IN (#{site.projects_ids.join(',')}) group by region_id order by count desc")
    result.map do |row|
      [Region.find(row['region_id'], :select => Region.custom_fields), row['count'].to_i]
    end
  end

  # to get only id and name
  def self.get_select_values
    scoped.select(:id,:name).order("name ASC")
  end

  # Agriculture - agriculture
  #   Camp Coordination & Management - camp_coordination
  #   Communications - communications
  #   Disaster Management - disaster_management
  #   Early Recovery - early_recovery
  #   Economic Recovery & Development - economic_recovery
  #   Education - education
  #   Emergency Telecommunications - emergency
  #   Environment - environment
  #   Food Aid - food_aid
  #   Food Security & Agriculture - food_security
  #   Health - health
  #   Human Rights, Democracy & Gov. - human_rights
  #   Logistics - logistics
  #   Other - other
  #   Nutrition - nutrition
  #   Peace & Security - peace_security
  #   Protection - protection
  #   Shelter & Housing - shelter
  #   Water, Sanitation & Hygiene - water_sanitation
  
  def css_class
    if (name.include? 'Agriculture')
       'agriculture'
    elsif (name.include? 'Camp Coordination')
       'camp_coordination'
    elsif (name.include? 'Disaster')
       'disaster_management'
    elsif (name.include? 'Early Recovery')
       'early_recovery'
     elsif (name.include? 'Early Recovery')
        'early_recovery'

   else
       'other'
    end
  end

end
