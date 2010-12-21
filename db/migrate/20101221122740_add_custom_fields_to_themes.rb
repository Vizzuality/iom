class AddCustomFieldsToThemes < ActiveRecord::Migration
  def self.up
    add_column :themes, :data, :text
  end

  def self.down
    remove_column :themes, :data
  end
end
