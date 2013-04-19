class AddOfficeIdToDonations < ActiveRecord::Migration
  def self.up
    add_column :donations, :office_id, :integer
  end

  def self.down
    remove_column :donations, :office_id
  end
end
