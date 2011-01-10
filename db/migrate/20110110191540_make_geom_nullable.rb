class MakeGeomNullable < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE projects ALTER COLUMN the_geom DROP NOT NULL;"
    execute "update projects set the_geom=null where id not in (select project_id from projects_regions)"
  end

  def self.down
  end
end
