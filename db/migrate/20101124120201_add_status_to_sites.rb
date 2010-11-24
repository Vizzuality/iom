class AddStatusToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :status, :boolean, :default => false
  end

  def self.down
    remove_column :sites, :status
  end
end
