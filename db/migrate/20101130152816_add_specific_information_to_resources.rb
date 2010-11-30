class AddSpecificInformationToResources < ActiveRecord::Migration
  def self.up
    add_column :resources, :site_specific_information, :text
  end

  def self.down
    remove_column :resources, :site_specific_information
  end
end
