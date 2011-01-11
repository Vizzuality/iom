class AddSortingColumnToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :order_index, :integer
    execute "UPDATE pages set order_index=id"
  end

  def self.down
    remove_column :pages, :order_index
  end
end
