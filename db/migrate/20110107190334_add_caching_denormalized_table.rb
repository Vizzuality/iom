class AddCachingDenormalizedTable < ActiveRecord::Migration
  def self.up
    create_table :data_denormalization, :id => false do |t|
      t.integer :project_id
      t.string :project_name, :limit => 2000
      t.text :project_description
      t.integer :organization_id
      t.string :organization_name, :limit => 2000
      t.date :end_date
      t.string :regions, :limit => 2000
      t.string :regions_ids, :limit => 2000
      t.string :countries, :limit => 2000
      t.string :countries_ids, :limit => 2000
      t.string :sectors, :limit => 2000
      t.string :sector_ids, :limit => 2000
      t.string :clusters, :limit => 2000
      t.string :cluster_ids, :limit => 2000
      t.boolean :is_active
      t.integer :site_id
    end
    
    add_index :data_denormalization, :project_id
    add_index :data_denormalization, :project_name
    add_index :data_denormalization, :organization_id
    add_index :data_denormalization, :organization_name
    add_index :data_denormalization, :regions_ids
    add_index :data_denormalization, :countries_ids
    add_index :data_denormalization, :sector_ids
    add_index :data_denormalization, :cluster_ids
    add_index :data_denormalization, :is_active
    add_index :data_denormalization, :site_id
    
  end

  def self.down
    drop_table :data_denormalization    
  end
end
