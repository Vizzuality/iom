class AddVisitsAndVisitsLastWeekToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :visits, :float, :default => 0
    add_column :sites, :visits_last_week, :float, :default => 0
  end

  def self.down
    remove_column :sites, :visits
    remove_column :sites, :visits_last_week
  end
end
