class CreateStats < ActiveRecord::Migration
  def self.up
    create_table :stats do |t|
      t.integer :site_id
      t.integer :visits
      t.date    :date
    end

    add_index :stats, :site_id
  end

  def self.down
    drop_table :stats
  end
end
