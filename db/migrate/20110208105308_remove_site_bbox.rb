class RemoveSiteBbox < ActiveRecord::Migration
  def self.up
    remove_column :sites, :overview_map_bbox_miny
    remove_column :sites, :overview_map_bbox_minx
    remove_column :sites, :overview_map_bbox_maxy
    remove_column :sites, :overview_map_bbox_maxx
    add_column :sites, :overview_map_lat, :float
    add_column :sites, :overview_map_lon, :float
    add_column :sites, :overview_map_zoom, :integer
  end

  def self.down
    add_column :sites, :overview_map_bbox_miny, :float
    add_column :sites, :overview_map_bbox_minx, :float
    add_column :sites, :overview_map_bbox_maxy, :float
    add_column :sites, :overview_map_bbox_maxx, :float
    remove_column :sites, :overview_map_lat
    remove_column :sites, :overview_map_lon
    remove_column :sites, :overview_map_zoom
  end
end
