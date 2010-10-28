class CreateDonors < ActiveRecord::Migration
  def self.up
    create_table :donors do |t|
      t.string :name
      t.text   :description
      t.string :contact_person_name
      t.string :contact_person_position
      t.string :contact_email
      t.string :contact_number
      t.timestamps
    end
  end

  def self.down
    drop_table :donors
  end
end
