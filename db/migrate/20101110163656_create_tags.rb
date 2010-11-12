class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
      t.integer :count, :default => 0
    end

    create_table :projects_tags, :id => false do |t|
      t.integer :tag_id
      t.integer :project_id
    end
  end

  def self.down
    drop_table :tags
    drop_table :projects_tags
  end
end
