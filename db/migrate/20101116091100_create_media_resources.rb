class CreateMediaResources < ActiveRecord::Migration
  def self.up
    create_table :media_resources do |t|
      t.integer  :position, :default => 0
      t.integer  :element_id
      t.integer  :element_type
      t.string   :picture_file_name
      t.string   :picture_content_type
      t.integer  :picture_filesize
      t.datetime :picture_updated_at
      t.string   :vimeo_url
      t.text     :vimeo_embed_html
      t.timestamps
    end
    add_index :media_resources, [:element_type, :element_id]
  end

  def self.down
    drop_table :media_resources
  end
end
