class AddExtraFieldsToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :activities, :text
    add_column :projects, :intervention_id, :string
    add_column :projects, :additional_information, :text
    add_column :projects, :awardee_type, :string
  end

  def self.down
    remove_column :projects, :activities
    remove_column :projects, :intervention_id
    remove_column :projects, :additional_information
    remove_column :projects, :awardee_type
  end
end
