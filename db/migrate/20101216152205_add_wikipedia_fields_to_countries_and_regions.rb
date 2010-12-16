class AddWikipediaFieldsToCountriesAndRegions < ActiveRecord::Migration
  def self.up
    add_column :countries, :wiki_url,         :string
    add_column :countries, :wiki_description, :text
    add_column :regions,   :wiki_url,         :string
    add_column :regions,   :wiki_description, :text
  end

  def self.down
    remove_column :countries, :wiki_url
    remove_column :countries, :wiki_description
    remove_column :regions,   :wiki_url
    remove_column :regions,   :wiki_description
  end
end
