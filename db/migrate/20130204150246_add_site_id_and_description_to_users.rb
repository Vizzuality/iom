class AddSiteIdAndDescriptionToUsers < ActiveRecord::Migration

  def self.up
    add_column :users, :site_id,     :string
    add_column :users, :description, :text
  end

  def self.down
    remove_column :users, :site_id
    remove_column :users, :description
  end

end
