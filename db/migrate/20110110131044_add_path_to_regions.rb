class AddPathToRegions < ActiveRecord::Migration
  def self.up
    execute "update regions as ur set path=(
    SELECT (((((( r3.country_id) || '/'::text) || r2.parent_region_id) || '/'::text) || r2.id) || '/'::text) || r3.id AS url
    FROM regions r3
    JOIN regions r2 ON r3.parent_region_id = r2.id
    WHERE r3.id=ur.id)"

    execute "update regions set path=country_id || '/' || parent_region_id || '/' || id where level=2"
    execute "update regions set path=country_id || '/' || id where level=1"
  end

  def self.down
  end
end
