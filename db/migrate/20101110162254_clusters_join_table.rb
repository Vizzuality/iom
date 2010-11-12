class ClustersJoinTable < ActiveRecord::Migration
  def self.up
    create_table :clusters_projects, :id => false do |t|
      t.integer :cluster_id
      t.integer :project_id
    end
  end

  def self.down
    drop_table :clusters_projects
  end
end
