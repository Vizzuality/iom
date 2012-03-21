class AddPolymorphicWhatToChangesHistories < ActiveRecord::Migration
  def self.up
    rename_column :changes_histories, :what, :how
    add_column :changes_histories, :what_id, :integer
    add_column :changes_histories, :what_type, :string
  end

  def self.down
    rename_column :changes_histories, :how, :what
    remove_column :changes_histories, :what_type
    remove_column :changes_histories, :what_id
  end
end
