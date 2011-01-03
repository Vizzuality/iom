class AddNavigateByAttributeInSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :navigate_by_country, :boolean, :default => false
    add_column :sites, :navigate_by_level1, :boolean, :default => false
    add_column :sites, :navigate_by_level2, :boolean, :default => false
    add_column :sites, :navigate_by_level3, :boolean, :default => false
  end

  def self.down
    remove_column :sites, :navigate_by_country
    remove_column :sites, :navigate_by_level1
    remove_column :sites, :navigate_by_level2
    remove_column :sites, :navigate_by_level3
  end
end
