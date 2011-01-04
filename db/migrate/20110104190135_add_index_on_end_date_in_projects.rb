class AddIndexOnEndDateInProjects < ActiveRecord::Migration
  def self.up
    add_index :projects, :end_date
  end

  def self.down
    remove_index :projects, :end_date
  end
end
