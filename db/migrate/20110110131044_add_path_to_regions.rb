class AddPathToRegions < ActiveRecord::Migration
  def self.up
    add_column :regions, :path, :string
  end

  def self.down
    remove_column :regions, :path
  end
end
