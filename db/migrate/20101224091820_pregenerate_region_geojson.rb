class PregenerateRegionGeojson < ActiveRecord::Migration
  def self.up
    add_column :regions, :the_geom_geojson, :text
    add_column :countries, :the_geom_geojson, :text
    execute "UPDATE regions SET the_geom_geojson=ST_AsGeoJSON(the_geom,6)"
    execute "UPDATE countries SET the_geom_geojson=ST_AsGeoJSON(the_geom,6)"
  end

  def self.down
  end
end
