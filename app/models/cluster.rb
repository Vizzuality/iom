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

  def css_class
    if (name.include? 'Agriculture')
       'agriculture'
    elsif (name.include? 'Camp Coordination')
    'camp_coordination'
    elsif (name.include? 'Disaster')
    'disastermanagement'
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
