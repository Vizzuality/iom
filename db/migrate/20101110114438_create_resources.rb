class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.string :title
      t.string :url
      t.integer :element_id
      t.integer :element_type
      t.timestamps
    end
    add_index :resources, [:element_type, :element_id]
  end

  def self.down
    drop_table :resources
  end
end
