class AddCaptionToMediaResources < ActiveRecord::Migration
  def self.up
    add_column :media_resources, :caption, :string
  end

  def self.down
    remove_column :media_resources, :caption
  end
end
