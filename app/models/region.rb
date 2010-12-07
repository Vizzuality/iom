# == Schema Information
#
# Table name: regions
#
#  id         :integer         not null, primary key
#  name       :string(255)     
#  country_id :integer         
#

class Region < ActiveRecord::Base

  acts_as_geom :the_geom => :multi_polygon

  belongs_to :country
  belongs_to :region, :foreign_key => :parent_region_id, :class_name => 'Region'
  
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
  # [[organization, count], [organization, count]]
  def projects_organizations(site)
    result = ActiveRecord::Base.connection.execute("select primary_organization_id, count(primary_organization_id) as count from projects where id IN (select project_id from projects_regions where region_id=#{self.id}) AND id IN (#{site.projects_ids.join(',')}) group by primary_organization_id order by count desc")
    result.map do |row|
      [Organization.find(row['primary_organization_id']), row['count'].to_i]
    end
  end

  def donors(site)
    projects.site(site).map do |project|
      project.donors
    end.flatten.uniq
  end

  def donors_budget(site)
    amount = 0
    donors(site).each { |donor| amount += donor.donations_amount }
    return amount
  end

end
