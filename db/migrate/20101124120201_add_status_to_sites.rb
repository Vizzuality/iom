class AddStatusToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :status, :boolean, :default => false
    add_index :sites, :status
  end

  def self.down
    remove_index :sites, :status
    remove_column :sites, :status
  end
end
