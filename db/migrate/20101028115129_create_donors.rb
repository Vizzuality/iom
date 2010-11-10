class CreateDonors < ActiveRecord::Migration
  def self.up
    create_table :donors do |t|
      t.string :name
      t.text   :description
      t.string :website
      t.string :twitter
      t.string :facebook
      t.string :contact_person_name
      t.string :contact_company
      t.string :contact_person_position
      t.string :contact_email
      t.string :contact_phone_number
      t.string :logo_file_name
      t.string :logo_content_type
      t.integer :logo_file_size
      t.datetime :logo_updated_at
      t.text     :site_specific_information
      t.timestamps
    end
  end

  def self.down
    drop_table :donors
  end
end
