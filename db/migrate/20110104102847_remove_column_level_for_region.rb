class RemoveColumnLevelForRegion < ActiveRecord::Migration
  def self.up
    remove_column :sites, :level_for_region
  end

  def self.down
    add_column :sites, :level_for_region, :integer
  end
end
