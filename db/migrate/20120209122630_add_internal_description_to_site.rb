class AddInternalDescriptionToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :internal_description, :text
  end

  def self.down
    remove_column :sites, :internal_description
  end
end
