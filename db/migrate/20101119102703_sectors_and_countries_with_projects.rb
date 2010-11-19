class SectorsAndCountriesWithProjects < ActiveRecord::Migration
  def self.up
    create_table :countries_projects, :id => false do |t|
      t.column :country_id, :integer
      t.column :project_id, :integer
    end
    create_table :projects_regions, :id => false do |t|
      t.column :region_id, :integer
      t.column :project_id, :integer
    end
  end

  def self.down
    drop_table :countries_projects
    drop_table :projects_regions
  end
end
