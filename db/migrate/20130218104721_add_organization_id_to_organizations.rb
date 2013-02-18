class AddOrganizationIdToOrganizations < ActiveRecord::Migration
  def self.up
    add_column :organizations, :organization_id, :string
  end

  def self.down
    remove_column :organizations, :organization_id
  end
end
