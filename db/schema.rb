# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101201174750) do

  create_table "clusters", :force => true do |t|
    t.column "name", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "clusters_projects", :id => false, :force => true do |t|
    t.column "cluster_id", :integer
    t.column "project_id", :integer
  end

  create_table "countries", :force => true do |t|
    t.column "name", :string
    t.column "code", :string
  end

  create_table "countries_projects", :id => false, :force => true do |t|
    t.column "country_id", :integer
    t.column "project_id", :integer
  end

  create_table "donations", :force => true do |t|
    t.column "donor_id", :integer
    t.column "project_id", :integer
    t.column "amount", :float
    t.column "date", :date
  end

  create_table "donors", :force => true do |t|
    t.column "name", :string
    t.column "description", :text
    t.column "website", :string
    t.column "twitter", :string
    t.column "facebook", :string
    t.column "contact_person_name", :string
    t.column "contact_company", :string
    t.column "contact_person_position", :string
    t.column "contact_email", :string
    t.column "contact_phone_number", :string
    t.column "logo_file_name", :string
    t.column "logo_content_type", :string
    t.column "logo_file_size", :integer
    t.column "logo_updated_at", :datetime
    t.column "site_specific_information", :text
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

# Could not dump table "geography_columns" because of following StandardError
#   Unknown type 'name' for column 'f_table_catalog' /Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/bundler/gems/postgis_adapter-31485fe86f12/lib/postgis_adapter/common_spatial_adapter.rb:52:in `table'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/bundler/gems/postgis_adapter-31485fe86f12/lib/postgis_adapter/common_spatial_adapter.rb:50:in `each'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/bundler/gems/postgis_adapter-31485fe86f12/lib/postgis_adapter/common_spatial_adapter.rb:50:in `table'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/activerecord-3.0.1/lib/active_record/schema_dumper.rb:75:in `tables'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/activerecord-3.0.1/lib/active_record/schema_dumper.rb:66:in `each'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/activerecord-3.0.1/lib/active_record/schema_dumper.rb:66:in `tables'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/activerecord-3.0.1/lib/active_record/schema_dumper.rb:27:in `dump'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/activerecord-3.0.1/lib/active_record/schema_dumper.rb:21:in `dump'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/activerecord-3.0.1/lib/active_record/railties/databases.rake:327/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/activerecord-3.0.1/lib/active_record/railties/databases.rake:326:in `open'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/activerecord-3.0.1/lib/active_record/railties/databases.rake:326/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:636:in `call'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:636:in `execute'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:631:in `each'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:631:in `execute'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:597:in `invoke_with_call_chain'/Users/jatorre/.rvm/rubies/ruby-1.8.7-p302/lib/ruby/1.8/monitor.rb:242:in `synchronize'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:590:in `invoke_with_call_chain'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:583:in `invoke'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/activerecord-3.0.1/lib/active_record/railties/databases.rake:143/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:636:in `call'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:636:in `execute'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:631:in `each'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:631:in `execute'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:597:in `invoke_with_call_chain'/Users/jatorre/.rvm/rubies/ruby-1.8.7-p302/lib/ruby/1.8/monitor.rb:242:in `synchronize'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:590:in `invoke_with_call_chain'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:583:in `invoke'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:2051:in `invoke_task'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:2029:in `top_level'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:2029:in `each'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:2029:in `top_level'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:2068:in `standard_exception_handling'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:2023:in `top_level'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:2001:in `run'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:2068:in `standard_exception_handling'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/lib/rake.rb:1998:in `run'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/gems/rake-0.8.7/bin/rake:31/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/bin/rake:19:in `load'/Users/jatorre/.rvm/gems/ruby-1.8.7-p302@iom/bin/rake:19

  create_table "media_resources", :force => true do |t|
    t.column "position", :integer, :default => 0
    t.column "element_id", :integer
    t.column "element_type", :integer
    t.column "picture_file_name", :string
    t.column "picture_content_type", :string
    t.column "picture_filesize", :integer
    t.column "picture_updated_at", :datetime
    t.column "vimeo_url", :string
    t.column "vimeo_embed_html", :text
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "caption", :string
  end

  create_table "organizations", :force => true do |t|
    t.column "name", :string
    t.column "description", :text
    t.column "budget", :float
    t.column "website", :string
    t.column "national_staff", :integer
    t.column "twitter", :string
    t.column "facebook", :string
    t.column "hq_address", :string
    t.column "contact_email", :string
    t.column "contact_phone_number", :string
    t.column "donation_address", :string
    t.column "zip_code", :string
    t.column "city", :string
    t.column "state", :string
    t.column "donation_phone_number", :string
    t.column "donation_website", :string
    t.column "site_specific_information", :text
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "logo_file_name", :string
    t.column "logo_content_type", :string
    t.column "logo_file_size", :integer
    t.column "logo_updated_at", :datetime
    t.column "international_staff", :string
    t.column "contact_name", :string
    t.column "contact_position", :string
    t.column "contact_zip", :string
    t.column "contact_city", :string
    t.column "contact_state", :string
    t.column "contact_country", :string
    t.column "donation_country", :string
    t.column "estimated_people_reached", :integer
    t.column "private_funding", :float
    t.column "usg_funding", :float
    t.column "other_funding", :float
    t.column "private_funding_spent", :float
    t.column "usg_funding_spent", :float
    t.column "other_funding_spent", :float
    t.column "spent_funding_on_relief", :float
    t.column "spent_funding_on_reconstruction", :float
    t.column "percen_relief", :integer
    t.column "percen_reconstruction", :integer
    t.column "media_contact_name", :string
    t.column "media_contact_position", :string
    t.column "media_contact_phone_number", :string
    t.column "media_contact_email", :string
  end

  create_table "organizations_projects", :id => false, :force => true do |t|
    t.column "organization_id", :integer
    t.column "project_id", :integer
  end

  create_table "pages", :force => true do |t|
    t.column "title", :string
    t.column "body", :text
    t.column "site_id", :integer
    t.column "highlighted", :boolean
    t.column "permalink", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "parent_id", :integer
  end

  add_index "pages", ["parent_id"], :name => "index_pages_on_parent_id"

  create_table "partners", :force => true do |t|
    t.column "site_id", :integer
    t.column "name", :string
    t.column "url", :string
    t.column "logo_file_name", :string
    t.column "logo_content_type", :string
    t.column "logo_file_size", :integer
    t.column "logo_updated_at", :datetime
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "projects", :force => true do |t|
    t.column "name", :text
    t.column "description", :text
    t.column "primary_organization_id", :integer
    t.column "implementing_organization", :string
    t.column "partner_organizations", :string
    t.column "cross_cutting_issues", :string
    t.column "start_date", :date
    t.column "end_date", :date
    t.column "budget", :integer
    t.column "target", :string
    t.column "estimated_people_reached", :integer
    t.column "contact_person", :string
    t.column "contact_email", :string
    t.column "contact_phone_number", :string
    t.column "site_specific_information", :text
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "the_geom", :geometry, :srid => 4326, :null => false
    t.column "activities", :text
    t.column "intervention_id", :string
    t.column "additional_information", :text
    t.column "awardee_type", :string
    t.column "date_provided", :date
    t.column "date_updated", :date
  end

  create_table "projects_regions", :id => false, :force => true do |t|
    t.column "region_id", :integer
    t.column "project_id", :integer
  end

  create_table "projects_sectors", :id => false, :force => true do |t|
    t.column "sector_id", :integer
    t.column "project_id", :integer
  end

  create_table "projects_tags", :id => false, :force => true do |t|
    t.column "tag_id", :integer
    t.column "project_id", :integer
  end

  create_table "regions", :force => true do |t|
    t.column "country_id", :integer
    t.column "name", :string
  end

  create_table "resources", :force => true do |t|
    t.column "title", :string
    t.column "url", :string
    t.column "element_id", :integer
    t.column "element_type", :integer
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "site_specific_information", :text
  end

  create_table "sectors", :force => true do |t|
    t.column "name", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "settings", :force => true do |t|
    t.column "default_email", :string
    t.column "default_contact_name", :string
    t.column "geoiq_parameter_1", :string
    t.column "geoiq_parameter_2", :string
    t.column "google_analytics_username", :string
    t.column "google_analytics_password", :string
  end

  create_table "sites", :force => true do |t|
    t.column "name", :string
    t.column "short_description", :text
    t.column "long_description", :text
    t.column "contact_email", :string
    t.column "contact_person", :string
    t.column "url", :string
    t.column "permalink", :string
    t.column "google_analytics_id", :string
    t.column "logo_file_name", :string
    t.column "logo_content_type", :string
    t.column "logo_file_size", :integer
    t.column "logo_updated_at", :datetime
    t.column "theme_id", :integer
    t.column "blog_url", :string
    t.column "word_for_clusters", :string
    t.column "word_for_regions", :string
    t.column "show_global_donations_raises", :boolean, :default => false
    t.column "project_classification", :integer, :default => 0
    t.column "geographic_context_country_id", :integer
    t.column "geographic_context_region_id", :integer
    t.column "project_context_cluster_id", :integer
    t.column "project_context_sector_id", :integer
    t.column "project_context_organization_id", :integer
    t.column "project_context_tags", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "project_context_tags_ids", :string
    t.column "geographic_context_geometry", :geometry, :srid => 4326
    t.column "status", :boolean, :default => false
    t.column "visits", :float, :default => 0.0
    t.column "visits_last_week", :float, :default => 0.0
  end

  add_index "sites", ["status"], :name => "index_sites_on_status"

  create_table "tags", :force => true do |t|
    t.column "name", :string
    t.column "count", :integer, :default => 0
  end

  create_table "themes", :force => true do |t|
    t.column "name", :string
    t.column "css_file", :string
    t.column "thumbnail_path", :string
  end

  create_table "users", :force => true do |t|
    t.column "name", :string, :limit => 100, :default => ""
    t.column "email", :string, :limit => 100
    t.column "crypted_password", :string, :limit => 40
    t.column "salt", :string, :limit => 40
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "remember_token", :string, :limit => 40
    t.column "remember_token_expires_at", :datetime
  end

end
