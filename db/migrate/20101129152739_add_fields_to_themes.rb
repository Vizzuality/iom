class AddFieldsToThemes < ActiveRecord::Migration
  def self.up
    add_column :themes, :css_file, :string
    add_column :themes, :thumbnail_path, :string
  end

  def self.down
    remove_column :themes, :css_file
    remove_column :themes, :thumbnail_path
  end
end
