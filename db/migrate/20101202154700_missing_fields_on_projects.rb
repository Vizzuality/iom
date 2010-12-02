class MissingFieldsOnProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.string :contact_position
      t.string :website
    end    
  end

  def self.down
  end
end
