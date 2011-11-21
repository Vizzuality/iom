class AddLabelToPartners < ActiveRecord::Migration
  def self.up
    add_column :partners, :label, :string
  end

  def self.down
    remove_column :partners, :label
  end
end
