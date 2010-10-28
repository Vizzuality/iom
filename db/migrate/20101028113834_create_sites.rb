class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string   :name
      t.text     :short_description
      t.text     :long_description
      t.string   :contact_email
      t.string   :contact_person
      t.string   :url
      t.string   :permalink
      t.boolean  :has_blog,           :default => false
      t.geometry :the_geom
      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
