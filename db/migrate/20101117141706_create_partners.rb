class CreatePartners < ActiveRecord::Migration
  def self.up
    create_table :partners do |t|
      t.integer  :site_id
      t.string   :name
      t.string   :url
      t.string   :logo_file_name
      t.string   :logo_content_type
      t.integer  :logo_file_size
      t.datetime :logo_updated_at
      t.timestamps
    end
    add_index :partners, :site_id
  end

  def self.down
    drop_table :partners
  end
end
