class ChangeNameLength < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.change :name, :text
    end
  end

  def self.down
  end
end
