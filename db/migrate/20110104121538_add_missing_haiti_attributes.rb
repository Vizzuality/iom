class AddMissingHaitiAttributes < ActiveRecord::Migration
  def self.up
    add_column :projects, :verbatim_location, :text
    add_column :projects, :calculation_of_number_of_people_reached, :text
    add_column :projects, :project_needs, :text
    add_column :projects, :idprefugee_camp, :text
  end

  def self.down
    remove_column :projects, :verbatim_location
    remove_column :projects, :calculation_of_number_of_people_reached
    remove_column :projects, :project_needs
    remove_column :projects, :idprefugee_camp
  end
end