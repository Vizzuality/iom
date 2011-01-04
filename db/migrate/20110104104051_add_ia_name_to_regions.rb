class AddIaNameToRegions < ActiveRecord::Migration
  def self.up
    add_column :regions, :ia_name, :text
    execute "UPDATE regions SET ia_name=name"
  end

  def self.down
     remove_column :regions, :ia_name
  end
end
