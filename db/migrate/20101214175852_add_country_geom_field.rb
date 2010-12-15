class AddCountryGeomField < ActiveRecord::Migration
  def self.up
    add_column :countries, :the_geom, :multi_polygon, :srid => 4326
    add_index :countries, :the_geom, :spatial => true
  end

  def self.down
  end
end
