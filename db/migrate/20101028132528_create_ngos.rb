class CreateNgos < ActiveRecord::Migration
  def self.up
    create_table :ngos do |t|
      t.string :name
      t.text :description
      t.string :website
      t.string :contact_person_name
      t.string :contact_person_position
      t.string :contact_email
      t.string :contact_phone_number
      t.text :donation_address
      t.string :donation_city
      t.string :donation_state
      t.string :zip_code
      t.string :donation_phone_number
      t.string :donation_webiste
      t.timestamps
    end
  end

  def self.down
    drop_table :ngos
  end
end
