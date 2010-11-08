class AddAttachmentLogoToOrganization < ActiveRecord::Migration
  def self.up
    add_column :organizations, :logo_file_name, :string
    add_column :organizations, :logo_content_type, :string
    add_column :organizations, :logo_file_size, :integer
    add_column :organizations, :logo_updated_at, :datetime
  end

  def self.down
    remove_column :organizations, :logo_file_name
    remove_column :organizations, :logo_content_type
    remove_column :organizations, :logo_file_size
    remove_column :organizations, :logo_updated_at
  end
end
