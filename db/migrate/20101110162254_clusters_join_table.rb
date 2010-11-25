class ClustersJoinTable < ActiveRecord::Migration
  def self.up
    create_table :clusters_projects, :id => false do |t|
      t.integer :cluster_id
      t.integer :project_id
    end
    add_index :clusters_projects, :cluster_id
    add_index :clusters_projects, :project_id
  end

  def self.down
    drop_table :clusters_projects
  end
end
