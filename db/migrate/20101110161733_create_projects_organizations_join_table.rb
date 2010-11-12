class CreateProjectsOrganizationsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :organizations_projects, :id => false do |t|
      t.integer :organization_id
      t.integer :project_id
    end
  end

  def self.down
    drop_table :organizations_projects
  end
end
