class AddAgencyIdToDonations < ActiveRecord::Migration
  def self.up
    add_column :donations, :agency_id, :integer
  end

  def self.down
    remove_column :donations, :agency_id
  end
end
