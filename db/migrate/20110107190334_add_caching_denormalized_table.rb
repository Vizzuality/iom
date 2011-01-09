class AddCachingDenormalizedTable < ActiveRecord::Migration
  def self.up
    execute "CREATE TABLE data_denormalization
    (
      project_id integer,
      project_name character varying(2000),
      project_description text,
      organization_id integer,
      organization_name character varying(2000),
      end_date date,
      regions text,
      regions_ids integer[],
      countries text,
      countries_ids integer[],
      sectors text,
      sector_ids integer[],
      clusters text,
      cluster_ids integer[],
      donors_ids integer[],
      is_active boolean,
      site_id integer,
      created_at timestamp without time zone
    ) WITH (OIDS=FALSE)"
    
    add_index :data_denormalization, :project_id
    add_index :data_denormalization, :project_name
    add_index :data_denormalization, :organization_id
    add_index :data_denormalization, :is_active
    add_index :data_denormalization, :site_id
    add_index :data_denormalization, :created_at
    
  end

  def self.down
    drop_table :data_denormalization    
  end
end
