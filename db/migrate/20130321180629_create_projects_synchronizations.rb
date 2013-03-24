class CreateProjectsSynchronizations < ActiveRecord::Migration
  def self.up
    create_table :projects_synchronizations do |t|
      t.text     :projects_file_data

      t.timestamps
    end
  end

  def self.down
    drop_table :projects_synchronizations
  end
end
