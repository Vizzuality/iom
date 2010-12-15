# == Schema Information
#
# Table name: countries
#
#  id   :integer         not null, primary key
#  name :string(255)     
#  code :string(255)     
#

class Country < ActiveRecord::Base

  has_many :regions
  has_and_belongs_to_many :projects do
    def site(site)
      self.where("projects.id IN (#{site.projects_ids.join(',')})")
    end
  end

  # Array of arrays
  # [[cluster, count], [cluster, count]]
  def projects_clusters(site)
    result = ActiveRecord::Base.connection.execute("select cluster_id, count(cluster_id) as count from clusters_projects where project_id IN (select project_id from projects_regions where region_id=#{self.id}) AND project_id IN (#{site.projects_ids.join(',')}) group by cluster_id order by count desc")
    result.map do |row|
      [Cluster.find(row['cluster_id']), row['count'].to_i]
    end
  end

  # Array of arrays
  # [[region, count], [region, count]]
  def regions_projects(site)
    regions.map do |region|
      count = (region.projects & site.projects).size
      next if count == 0
      [region, count]
    end.compact
  end

  def donors(site)
    projects.site(site).map do |project|
      project.donors
    end.flatten.uniq
  end

  # to get only id and name  
  def self.get_select_values
    scoped.select(:id,:name).order("name ASC")
  end

end
