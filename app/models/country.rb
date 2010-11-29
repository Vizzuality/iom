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
  has_and_belongs_to_many :projects

  # Array of arrays
  # [[cluster, count], [cluster, count]]
  def projects_clusters
    result = ActiveRecord::Base.connection.execute("select cluster_id, count(cluster_id) as count from clusters_projects where project_id IN (select project_id from projects_regions where region_id=#{self.id}) group by cluster_id order by count desc")
    result.map do |row|
      [Cluster.find(row['cluster_id']), row['count'].to_i]
    end
  end

  # Array of arrays
  # [[region, count], [region, count]]
  def regions_projects
    regions.map do |region|
      [region, region.projects.count]
    end
  end

  def donors
    Donor.where("id in (select donor_id from donations, projects_regions where donations.project_id = projects_regions.project_id and projects_regions.region_id = #{self.id} )")
  end

end
