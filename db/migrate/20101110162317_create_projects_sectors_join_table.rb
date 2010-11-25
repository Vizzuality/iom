class CreateProjectsSectorsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :projects_sectors, :id => false do |t|
      t.integer :sector_id
      t.integer :project_id
    end
    add_index :projects_sectors, :sector_id
    add_index :projects_sectors, :project_id
  end

  def self.down
    drop_table :projects_sectors
  end
end
