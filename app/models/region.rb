# == Schema Information
#
# Table name: regions
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  country_id :integer
#

class Region < ActiveRecord::Base

  belongs_to :country
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
  # [[organization, count], [organization, count]]
  def projects_organizations
    result = ActiveRecord::Base.connection.execute("select primary_organization_id, count(primary_organization_id) as count from projects where id IN (select project_id from projects_regions where region_id=#{self.id}) group by primary_organization_id order by count desc")
    result.map do |row|
      [Organization.find(row['primary_organization_id']), row['count'].to_i]
    end
  end

  def donors
    Donor.where("id in (select donor_id from donations, projects_regions where donations.project_id = projects_regions.project_id and projects_regions.region_id = #{self.id} )")
  end

  def donors_budget
    amount = 0
    donors.each { |donor| amount += donor.donations_amount }
    return amount
  end

end
