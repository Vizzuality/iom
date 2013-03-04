class AddIndexToChangesHistoryRecords < ActiveRecord::Migration

  def self.up
    add_index :changes_history_records, [:user_id, :what_type, :when]
  end

  def self.down
    remove_index :changes_history_records, [:user_id, :what_type, :when]
  end

end
