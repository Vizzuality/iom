class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string      :name
      t.text        :description
      t.float       :budget
      t.string      :website
      t.integer     :staff
      t.string      :twitter
      t.string      :facebook
      t.string      :hq_address
      t.string      :contact_email
      t.string      :contact_phone_number
      t.string      :donation_address
      t.string      :zip_code
      t.string      :city
      t.string      :state
      t.string      :donation_phone_number
      t.string      :donation_website
      t.text        :site_specific_information
      t.timestamps
    end
    add_index :organizations, :name
  end

  def self.down
    drop_table :organizations
  end
end
