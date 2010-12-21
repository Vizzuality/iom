class AddBboxFieldsToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :overview_map_bbox_miny, :float
    add_column :sites, :overview_map_bbox_minx, :float
    add_column :sites, :overview_map_bbox_maxy, :float
    add_column :sites, :overview_map_bbox_maxx, :float
  end

  def self.down
    remove_column :sites, :overview_map_bbox_miny
    remove_column :sites, :overview_map_bbox_minx
    remove_column :sites, :overview_map_bbox_maxy
    remove_column :sites, :overview_map_bbox_maxx
  end
end
