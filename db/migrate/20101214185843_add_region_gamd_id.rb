class AddRegionGamdId < ActiveRecord::Migration
  def self.up
    add_column :regions, :gadm_id, :integer
  end

  def self.down
  end
end
