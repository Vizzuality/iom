class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.integer :country_id
      t.string  :name
    end
  end

  def self.down
    drop_table :regions
  end
end
