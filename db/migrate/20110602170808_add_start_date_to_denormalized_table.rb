class AddStartDateToDenormalizedTable < ActiveRecord::Migration
  def self.up
    execute 'ALTER TABLE data_denormalization ADD COLUMN start_date date;'
  end

  def self.down
    execute 'ALTER TABLE data_denormalization DROP COLUMN start_date;'
  end
end
