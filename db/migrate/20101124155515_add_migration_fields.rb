class AddMigrationFields < ActiveRecord::Migration
  def self.up
    add_column :organizations, :international_staff, :string
    add_column :organizations, :contact_name, :string
    add_column :organizations, :contact_position, :string
    add_column :organizations, :contact_zip, :string
    add_column :organizations, :contact_city, :string
    add_column :organizations, :contact_state, :string
    add_column :organizations, :contact_country, :string
    add_column :organizations, :donation_country, :string
  end

  def self.down
    remove_column :organizations, :international_staff
    remove_column :organizations, :contact_name
    remove_column :organizations, :contact_position
    remove_column :organizations, :contact_zip
    remove_column :organizations, :contact_city
    remove_column :organizations, :contact_state
    remove_column :organizations, :contact_country
    remove_column :organizations, :donation_country
  end
end
