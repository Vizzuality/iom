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
    result = ActiveRecord::Base.connection.execute("select region_id, count(region_id) as count from projects_regions where project_id IN (select project_id from projects_sectors where sector_id=#{self.id}) AND project_id IN (#{site.projects_ids.join(',')}) group by region_id order by count desc")
    result.map do |row|
      [Region.find(row['region_id'], :select => Region.custom_fields), row['count'].to_i]
    end
  end

  # to get only id and name
  def self.get_select_values
    scoped.select(:id,:name).order("name ASC")
  end

  def css_class
    if name.include?('Agriculture')
      'agriculture'
    elsif name.include?('Communications')
      'communications'
    elsif name.include?('Disaster')
      'disaster'
    elsif name.include?('Economic')
      'economic'
    elsif name.include?('Education')
      'education'
    elsif name.include?('Environment')
      'environment'
    elsif name.include?('Food')
      'food'
    elsif name.include?('Health')
      'health'
    elsif name.include?('Human')
      'human'
    elsif name.include?('Democracy')
      'democracy'
    elsif name.include?('Peace')
      'peace'
    elsif name.include?('Protection')
      'protection'
    elsif name.include?('Shelter')
      'shelter'
    elsif name.include?('Water')
      'water'
    elsif name.include?('Sanitation')
      'sanitation'
    elsif name.include?('Other')
      'other'
    elsif name.include?('Water')
      'water'
    elsif name.include?('Human')
      'human'
    elsif name.include?('Nutrition')
      'nutrition'
    else
      ''
    end
  end
end
