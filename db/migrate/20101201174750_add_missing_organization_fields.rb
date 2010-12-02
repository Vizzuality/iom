class AddMissingOrganizationFields < ActiveRecord::Migration
  def self.up
    change_table :organizations do |t|
      t.integer :estimated_people_reached
      t.float :private_funding
      t.float :usg_funding
      t.float :other_funding
      t.float :private_funding_spent
      t.float :usg_funding_spent
      t.float :other_funding_spent
      t.float :spent_funding_on_relief
      t.float :spent_funding_on_reconstruction
      t.integer :percen_relief
      t.integer :percen_reconstruction
      t.rename :staff, :national_staff
      t.string :media_contact_name
      t.string :media_contact_position
      t.string :media_contact_phone_number
      t.string :media_contact_email
    end
  end

  def self.down
  end
end
