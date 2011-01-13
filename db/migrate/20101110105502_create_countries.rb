class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :name
      t.string :code
      t.float :center_lat
      t.float :center_lon
    end
  end

  def self.down
    drop_table :countries
  end
end
