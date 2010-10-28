class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.geometry :the_geom
      t.integer :ngo_id
      t.string :name
      t.text :description
      t.integer :cluster_id
      t.date :start_date
      t.date :end_date
      t.integer :people_reached
      t.float :area_covered
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
