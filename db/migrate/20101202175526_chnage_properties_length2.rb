class ChnagePropertiesLength2 < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.change :name, :string, :limit => 2000
    end    
    change_table :donors do |t|
      t.change :name, :string, :limit => 2000
    end    
  end

  def self.down
  end
end
