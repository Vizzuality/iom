class RemoveAgenciesReferences < ActiveRecord::Migration
  def self.up
    drop_table :agencies
    remove_column :donations, :agency_id
  end

  def self.down
    create_table :agencies do |t|
      t.references :donor
      t.string :name

      t.timestamps
    end
    add_column :donations, :agency_id, :integer
  end
end
