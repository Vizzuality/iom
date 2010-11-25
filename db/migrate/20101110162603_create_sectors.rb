class CreateSectors < ActiveRecord::Migration
  def self.up
    create_table :sectors do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :sectors
  end
end
