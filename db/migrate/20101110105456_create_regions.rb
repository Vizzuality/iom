class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.string      :name
      t.integer     :level
      t.integer     :country_id
      t.integer     :parent_region_id
      t.float       :center_lat
      t.float       :center_lon
      t.string      :path
      t.geometry    :the_geom, :srid => 4326
    end
    add_index :regions, :country_id
    add_index :regions, :level
    add_index :regions, :parent_region_id
    add_index :regions, :the_geom, :spatial=>true
  end

  def self.down
    drop_table :regions
  end
end
