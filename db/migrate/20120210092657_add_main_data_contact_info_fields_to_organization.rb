class AddMainDataContactInfoFieldsToOrganization < ActiveRecord::Migration
  def self.up
    add_column :organizations, :main_data_contact_name        , :string
    add_column :organizations, :main_data_contact_position    , :string
    add_column :organizations, :main_data_contact_phone_number, :string
    add_column :organizations, :main_data_contact_email       , :string
    add_column :organizations, :main_data_contact_zip         , :string
    add_column :organizations, :main_data_contact_city        , :string
    add_column :organizations, :main_data_contact_state       , :string
    add_column :organizations, :main_data_contact_country     , :string
  end

  def self.down
    remove_column :organizations, :main_data_contact_name
    remove_column :organizations, :main_data_contact_position
    remove_column :organizations, :main_data_contact_phone_number
    remove_column :organizations, :main_data_contact_email
    remove_column :organizations, :main_data_contact_zip
    remove_column :organizations, :main_data_contact_city
    remove_column :organizations, :main_data_contact_state
    remove_column :organizations, :main_data_contact_country
  end
end
