class AddOrganizationIdToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :organization_id, :string
  end

  def self.down
    remove_column :projects, :organization_id
  end
end
