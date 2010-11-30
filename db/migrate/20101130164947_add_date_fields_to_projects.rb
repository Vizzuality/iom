class AddDateFieldsToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :date_provided, :date
    add_column :projects, :date_updated, :date
  end

  def self.down
    remove_column :projects, :date_provided
    remove_column :projects, :date_updated
  end
end
