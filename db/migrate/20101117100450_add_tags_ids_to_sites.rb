class AddTagsIdsToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :project_context_tags_ids, :string
  end

  def self.down
    remove_column :sites, :project_context_tags_ids
  end
end
