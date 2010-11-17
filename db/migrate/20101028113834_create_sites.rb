class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string   :name
      t.text     :short_description
      t.text     :long_description
      t.string   :contact_email
      t.string   :contact_person
      t.string   :url
      t.string   :permalink
      t.string   :google_analytics_id
      t.string   :logo_file_name
      t.string   :logo_content_type
      t.integer  :logo_file_size
      t.datetime :logo_updated_at
      t.integer  :theme_id
      t.string   :blog_url
      t.string   :word_for_clusters
      t.string   :word_for_regions
      t.boolean  :show_global_donations_raises, :default => false
      t.integer  :project_classification, :default => 0
      t.integer  :geographic_context_country_id
      t.integer  :geographic_context_region_id
      t.geometry :geographic_context_geometry, :srid => 4326
      t.integer  :project_context_cluster_id
      t.integer  :project_context_organization_id
      t.string   :project_context_tags
      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
