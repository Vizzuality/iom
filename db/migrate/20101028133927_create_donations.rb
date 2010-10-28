class CreateDonations < ActiveRecord::Migration
  def self.up
    create_table :donations do |t|
      t.integer :donor_id
      t.integer :project_id
      t.integer :amount
      t.timestamps
    end
  end

  def self.down
    drop_table :donations
  end
end
