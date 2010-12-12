class AddProjectsSitesCacheTable < ActiveRecord::Migration
  def self.up
    create_table :projects_sites, :id => false do |t|
      t.integer :project_id
      t.integer :site_id
    end
    
    add_index :projects_sites, :project_id
    add_index :projects_sites, :site_id
    add_index :projects_sites, [:project_id, :site_id], :unique => true
  end

  def self.down
    drop_table :projects_sites
  end
end
