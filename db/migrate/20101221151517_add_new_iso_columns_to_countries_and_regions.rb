class AddNewIsoColumnsToCountriesAndRegions < ActiveRecord::Migration
  def self.up
    add_column :countries, :iso2_code, :string
    add_column :countries, :iso3_code, :string
    add_column :regions, :code, :string
  end

  def self.down
    remove_column :countries, :iso2_code
    remove_column :countries, :iso3_code
    add_column :regions, :code
  end
end
