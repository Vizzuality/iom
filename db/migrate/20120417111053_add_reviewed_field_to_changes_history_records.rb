class AddReviewedFieldToChangesHistoryRecords < ActiveRecord::Migration
  def self.up
    add_column :changes_history_records, :reviewed, :boolean, :default => false
  end

  def self.down
    remove_column :changes_history_records, :reviewed
  end
end
