class AddLevelForRegionInSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :level_for_region, :integer, :default => 1
    Site.all.each{ |s| s.update_attribute(:level_for_region, 1) }
  end

  def self.down
    remove_column :sites, :level_for_region
  end
end
