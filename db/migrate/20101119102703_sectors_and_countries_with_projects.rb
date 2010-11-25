class SectorsAndCountriesWithProjects < ActiveRecord::Migration
  def self.up
    create_table :countries_projects, :id => false do |t|
      t.column :country_id, :integer
      t.column :project_id, :integer
    end
    add_index :countries_projects, :country_id
    add_index :countries_projects, :project_id

    create_table :projects_regions, :id => false do |t|
      t.column :region_id, :integer
      t.column :project_id, :integer
    end
    add_index :projects_regions, :region_id
    add_index :projects_regions, :project_id
  end

  def self.down
    drop_table :countries_projects
    drop_table :projects_regions
  end
end
