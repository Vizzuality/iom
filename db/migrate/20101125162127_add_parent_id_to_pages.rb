class AddParentIdToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :parent_id, :integer
    add_index :pages, :parent_id
  end

  def self.down
    remove_index :pages, :parent_id
    remove_column :pages, :parent_id
  end
end
