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

ActiveRecord::Schema.define(:version => 20101211105820) do

  create_table "clusters", :force => true do |t|
    t.string "name"
  end

  create_table "clusters_projects", :id => false, :force => true do |t|
    t.integer "cluster_id"
    t.integer "project_id"
  end

  add_index "clusters_projects", ["cluster_id"], :name => "index_clusters_projects_on_cluster_id"
  add_index "clusters_projects", ["project_id"], :name => "index_clusters_projects_on_project_id"

  create_table "countries", :force => true do |t|
    t.string "name"
    t.string "code"
  end

  create_table "countries_projects", :id => false, :force => true do |t|
    t.integer "country_id"
    t.integer "project_id"
  end

  add_index "countries_projects", ["country_id"], :name => "index_countries_projects_on_country_id"
  add_index "countries_projects", ["project_id"], :name => "index_countries_projects_on_project_id"

  create_table "donations", :force => true do |t|
    t.integer "donor_id"
    t.integer "project_id"
    t.float   "amount"
    t.date    "date"
  end

  add_index "donations", ["donor_id"], :name => "index_donations_on_donor_id"
  add_index "donations", ["project_id"], :name => "index_donations_on_project_id"

  create_table "donors", :force => true do |t|
    t.string   "name",                      :limit => 2000
    t.text     "description"
    t.string   "website"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "contact_person_name"
    t.string   "contact_company"
    t.string   "contact_person_position"
    t.string   "contact_email"
    t.string   "contact_phone_number"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.text     "site_specific_information"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "donors", ["name"], :name => "index_donors_on_name"

  create_table "media_resources", :force => true do |t|
    t.integer  "position",             :default => 0
    t.integer  "element_id"
    t.integer  "element_type"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_filesize"
    t.datetime "picture_updated_at"
    t.string   "vimeo_url"
    t.text     "vimeo_embed_html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "caption"
  end

  add_index "media_resources", ["element_id", "element_type"], :name => "index_media_resources_on_element_type_and_element_id"

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "budget"
    t.string   "website"
    t.integer  "national_staff"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "hq_address"
    t.string   "contact_email"
    t.string   "contact_phone_number"
    t.string   "donation_address"
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.string   "donation_phone_number"
    t.string   "donation_website"
    t.text     "site_specific_information"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "international_staff"
    t.string   "contact_name"
    t.string   "contact_position"
    t.string   "contact_zip"
    t.string   "contact_city"
    t.string   "contact_state"
    t.string   "contact_country"
    t.string   "donation_country"
    t.integer  "estimated_people_reached"
    t.float    "private_funding"
    t.float    "usg_funding"
    t.float    "other_funding"
    t.float    "private_funding_spent"
    t.float    "usg_funding_spent"
    t.float    "other_funding_spent"
    t.float    "spent_funding_on_relief"
    t.float    "spent_funding_on_reconstruction"
    t.integer  "percen_relief"
    t.integer  "percen_reconstruction"
    t.string   "media_contact_name"
    t.string   "media_contact_position"
    t.string   "media_contact_phone_number"
    t.string   "media_contact_email"
  end

  add_index "organizations", ["name"], :name => "index_organizations_on_name"

  create_table "organizations_projects", :id => false, :force => true do |t|
    t.integer "organization_id"
    t.integer "project_id"
  end

  add_index "organizations_projects", ["organization_id"], :name => "index_organizations_projects_on_organization_id"
  add_index "organizations_projects", ["project_id"], :name => "index_organizations_projects_on_project_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "site_id"
    t.boolean  "published",  :default => false
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
  end

  add_index "pages", ["parent_id"], :name => "index_pages_on_parent_id"
  add_index "pages", ["permalink"], :name => "index_pages_on_permalink"
  add_index "pages", ["site_id"], :name => "index_pages_on_site_id"

  create_table "partners", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.string   "url"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "partners", ["site_id"], :name => "index_partners_on_site_id"

  create_table "projects", :force => true do |t|
    t.string   "name",                      :limit => 2000
    t.text     "description"
    t.integer  "primary_organization_id"
    t.text     "implementing_organization"
    t.text     "partner_organizations"
    t.text     "cross_cutting_issues"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "budget"
    t.text     "target"
    t.integer  "estimated_people_reached"
    t.string   "contact_person"
    t.string   "contact_email"
    t.string   "contact_phone_number"
    t.text     "site_specific_information"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "activities"
    t.string   "intervention_id"
    t.text     "additional_information"
    t.string   "awardee_type"
    t.geometry "the_geom",                  :limit => nil,  :null => false, :srid => 4326
    t.date     "date_provided"
    t.date     "date_updated"
    t.string   "contact_position"
    t.string   "website"
  end

  add_index "projects", ["name"], :name => "index_projects_on_name"
  add_index "projects", ["primary_organization_id"], :name => "index_projects_on_primary_organization_id"

  create_table "projects_regions", :id => false, :force => true do |t|
    t.integer "region_id"
    t.integer "project_id"
  end

  add_index "projects_regions", ["project_id"], :name => "index_projects_regions_on_project_id"
  add_index "projects_regions", ["region_id"], :name => "index_projects_regions_on_region_id"

  create_table "projects_sectors", :id => false, :force => true do |t|
    t.integer "sector_id"
    t.integer "project_id"
  end

  add_index "projects_sectors", ["project_id"], :name => "index_projects_sectors_on_project_id"
  add_index "projects_sectors", ["sector_id"], :name => "index_projects_sectors_on_sector_id"

  create_table "projects_tags", :id => false, :force => true do |t|
    t.integer "tag_id"
    t.integer "project_id"
  end

  add_index "projects_tags", ["project_id"], :name => "index_projects_tags_on_project_id"
  add_index "projects_tags", ["tag_id"], :name => "index_projects_tags_on_tag_id"

  create_table "regions", :force => true do |t|
    t.string  "name"
    t.integer "country_id"
  end

  add_index "regions", ["country_id"], :name => "index_regions_on_country_id"

  create_table "resources", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "element_id"
    t.integer  "element_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "site_specific_information"
  end

  add_index "resources", ["element_id", "element_type"], :name => "index_resources_on_element_type_and_element_id"

  create_table "sectors", :force => true do |t|
    t.string "name"
  end

  create_table "settings", :force => true do |t|
    t.text "data"
  end

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.text     "short_description"
    t.text     "long_description"
    t.string   "contact_email"
    t.string   "contact_person"
    t.string   "url"
    t.string   "permalink"
    t.string   "google_analytics_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "theme_id"
    t.string   "blog_url"
    t.string   "word_for_clusters"
    t.string   "word_for_regions"
    t.boolean  "show_global_donations_raises",                   :default => false
    t.integer  "project_classification",                         :default => 0
    t.integer  "geographic_context_country_id"
    t.integer  "geographic_context_region_id"
    t.integer  "project_context_cluster_id"
    t.integer  "project_context_sector_id"
    t.integer  "project_context_organization_id"
    t.string   "project_context_tags"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "project_context_tags_ids"
    t.boolean  "status",                                         :default => false
    t.float    "visits",                                         :default => 0.0
    t.float    "visits_last_week",                               :default => 0.0
    t.geometry "geographic_context_geometry",     :limit => nil,                    :srid => 4326
  end

  add_index "sites", ["name"], :name => "index_sites_on_name"
  add_index "sites", ["status"], :name => "index_sites_on_status"
  add_index "sites", ["url"], :name => "index_sites_on_url"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "count", :default => 0
  end

  create_table "themes", :force => true do |t|
    t.string "name"
    t.string "css_file"
    t.string "thumbnail_path"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"

end
