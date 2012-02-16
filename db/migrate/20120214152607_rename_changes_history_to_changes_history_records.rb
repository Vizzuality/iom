class RenameChangesHistoryToChangesHistoryRecords < ActiveRecord::Migration
  def self.up
    rename_table :changes_histories, :changes_history_records
  end

  def self.down
    rename_table :changes_history_records, :changes_histories
  end
end
