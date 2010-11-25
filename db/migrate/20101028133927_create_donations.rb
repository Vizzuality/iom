class CreateDonations < ActiveRecord::Migration
  def self.up
    create_table :donations do |t|
      t.integer :donor_id
      t.integer :project_id
      t.float :amount
      t.date  :date
    end
    add_index :donations, :donor_id
    add_index :donations, :project_id
  end

  def self.down
    drop_table :donations
  end
end
