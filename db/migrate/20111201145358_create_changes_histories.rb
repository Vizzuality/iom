class CreateChangesHistories < ActiveRecord::Migration
  def self.up
    create_table :changes_histories do |t|
      t.references :user
      t.datetime :when
      t.text :what

      t.timestamps
    end
  end

  def self.down
    drop_table :changes_histories
  end
end
