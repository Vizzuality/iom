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

ActiveRecord::Schema.define(:version => 20111201115943) do

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
    t.string        "name"
    t.string        "code"
    t.multi_polygon "the_geom",         :limit => nil, :srid => 4326
    t.string        "wiki_url"
    t.text          "wiki_description"
    t.string        "iso2_code"
    t.string        "iso3_code"
    t.float         "center_lat"
    t.float         "center_lon"
    t.text          "the_geom_geojson"
  end

  add_index "countries", ["the_geom"], :name => "index_countries_on_the_geom", :spatial => true

  create_table "countries_projects", :id => false, :force => true do |t|
    t.integer "country_id", :null => false
    t.integer "project_id", :null => false
  end

  add_index "countries_projects", ["country_id"], :name => "index_countries_projects_on_country_id"
  add_index "countries_projects", ["project_id"], :name => "index_countries_projects_on_project_id"

  create_table "data_denormalization", :id => false, :force => true do |t|
    t.integer  "project_id"
    t.string   "project_name",        :limit => 2000
    t.text     "project_description"
    t.integer  "organization_id"
    t.string   "organization_name",   :limit => 2000
    t.date     "end_date"
    t.text     "regions"
    t.string   "regions_ids",         :limit => nil
    t.text     "countries"
    t.string   "countries_ids",       :limit => nil
    t.text     "sectors"
    t.string   "sector_ids",          :limit => nil
    t.text     "clusters"
    t.string   "cluster_ids",         :limit => nil
    t.string   "donors_ids",          :limit => nil
    t.boolean  "is_active"
    t.integer  "site_id"
    t.datetime "created_at"
    t.date     "start_date"
  end

  add_index "data_denormalization", ["cluster_ids"], :name => "data_denormalization_cluster_idsx"
  add_index "data_denormalization", ["countries_ids"], :name => "data_denormalization_countries_idsx"
  add_index "data_denormalization", ["donors_ids"], :name => "data_denormalization_donors_idsx"
  add_index "data_denormalization", ["is_active"], :name => "data_denormalization_is_activex"
  add_index "data_denormalization", ["organization_id"], :name => "data_denormalization_organization_idx"
  add_index "data_denormalization", ["organization_name"], :name => "data_denormalization_organization_namex"
  add_index "data_denormalization", ["project_id"], :name => "data_denormalization_project_idx"
  add_index "data_denormalization", ["project_name"], :name => "data_denormalization_project_name_idx"
  add_index "data_denormalization", ["regions_ids"], :name => "data_denormalization_regions_idsx"
  add_index "data_denormalization", ["sector_ids"], :name => "data_denormalization_sector_idsx"
  add_index "data_denormalization", ["site_id"], :name => "data_denormalization_site_idx"

  create_table "data_export", :id => false, :force => true do |t|
    t.integer "project_id"
    t.string  "project_name",                            :limit => 2000
    t.text    "project_description"
    t.integer "organization_id"
    t.string  "organization_name",                       :limit => 2000
    t.text    "implementing_organization"
    t.text    "partner_organizations"
    t.text    "cross_cutting_issues"
    t.date    "start_date"
    t.date    "end_date"
    t.float   "budget"
    t.text    "target"
    t.integer "estimated_people_reached",                :limit => 8
    t.string  "project_contact_person"
    t.string  "project_contact_email"
    t.string  "project_contact_phone_number"
    t.text    "activities"
    t.string  "intervention_id"
    t.text    "additional_information"
    t.string  "awardee_type"
    t.date    "date_provided"
    t.date    "date_updated"
    t.string  "project_contact_position"
    t.string  "project_website"
    t.text    "verbatim_location"
    t.text    "calculation_of_number_of_people_reached"
    t.text    "project_needs"
    t.text    "sectors"
    t.text    "clusters"
    t.text    "project_tags"
    t.text    "countries"
    t.text    "regions_level1"
    t.text    "regions_level2"
    t.text    "regions_level3"
  end

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
    t.integer  "position",                 :default => 0
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
    t.string   "vimeo_thumb_file_name"
    t.string   "vimeo_thumb_content_type"
    t.integer  "vimeo_thumb_file_size"
    t.datetime "vimeo_thumb_updated_at"
  end

  add_index "media_resources", ["element_type", "element_id"], :name => "index_media_resources_on_element_type_and_element_id"

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

  create_table "organizations2", :force => true do |t|
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

  add_index "organizations2", ["name"], :name => "index_organizations2_on_name"

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
    t.boolean  "published"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "order_index"
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
    t.string   "label"
  end

  add_index "partners", ["site_id"], :name => "index_partners_on_site_id"

  create_table "projects", :force => true do |t|
    t.string   "name",                                    :limit => 2000
    t.text     "description"
    t.integer  "primary_organization_id"
    t.text     "implementing_organization"
    t.text     "partner_organizations"
    t.text     "cross_cutting_issues"
    t.date     "start_date"
    t.date     "end_date"
    t.float    "budget"
    t.text     "target"
    t.integer  "estimated_people_reached",                :limit => 8
    t.string   "contact_person"
    t.string   "contact_email"
    t.string   "contact_phone_number"
    t.text     "site_specific_information"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.geometry "the_geom",                                :limit => nil,  :srid => 4326
    t.text     "activities"
    t.string   "intervention_id"
    t.text     "additional_information"
    t.string   "awardee_type"
    t.date     "date_provided"
    t.date     "date_updated"
    t.string   "contact_position"
    t.string   "website"
    t.text     "verbatim_location"
    t.text     "calculation_of_number_of_people_reached"
    t.text     "project_needs"
    t.text     "idprefugee_camp"
  end

  add_index "projects", ["end_date"], :name => "index_projects_on_end_date"
  add_index "projects", ["name"], :name => "index_projects_on_name"
  add_index "projects", ["primary_organization_id"], :name => "index_projects_on_primary_organization_id"
  add_index "projects", ["the_geom"], :name => "index_projects_on_the_geom", :spatial => true

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

  create_table "projects_sites", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "site_id"
  end

  add_index "projects_sites", ["project_id", "site_id"], :name => "index_projects_sites_on_project_id_and_site_id", :unique => true
  add_index "projects_sites", ["project_id"], :name => "index_projects_sites_on_project_id"
  add_index "projects_sites", ["site_id"], :name => "index_projects_sites_on_site_id"

  create_table "projects_tags", :id => false, :force => true do |t|
    t.integer "tag_id"
    t.integer "project_id"
  end

  add_index "projects_tags", ["project_id"], :name => "index_projects_tags_on_project_id"
  add_index "projects_tags", ["tag_id"], :name => "index_projects_tags_on_tag_id"

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.integer  "country_id"
    t.integer  "parent_region_id"
    t.geometry "the_geom",         :limit => nil, :srid => 4326
    t.integer  "gadm_id"
    t.string   "wiki_url"
    t.text     "wiki_description"
    t.string   "code"
    t.float    "center_lat"
    t.float    "center_lon"
    t.text     "the_geom_geojson"
    t.text     "ia_name"
    t.string   "path"
  end

  add_index "regions", ["country_id"], :name => "index_regions_on_country_id"
  add_index "regions", ["level"], :name => "index_regions_on_level"
  add_index "regions", ["parent_region_id"], :name => "index_regions_on_parent_region_id"
  add_index "regions", ["the_geom"], :name => "index_regions_on_the_geom", :spatial => true

  create_table "resources", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "element_id"
    t.integer  "element_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "site_specific_information"
  end

  add_index "resources", ["element_type", "element_id"], :name => "index_resources_on_element_type_and_element_id"

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
    t.geometry "geographic_context_geometry",     :limit => nil,                    :srid => 4326
    t.string   "project_context_tags_ids"
    t.boolean  "status",                                         :default => false
    t.float    "visits",                                         :default => 0.0
    t.float    "visits_last_week",                               :default => 0.0
    t.string   "aid_map_image_file_name"
    t.string   "aid_map_image_content_type"
    t.integer  "aid_map_image_file_size"
    t.datetime "aid_map_image_updated_at"
    t.boolean  "navigate_by_country",                            :default => false
    t.boolean  "navigate_by_level1",                             :default => false
    t.boolean  "navigate_by_level2",                             :default => false
    t.boolean  "navigate_by_level3",                             :default => false
    t.text     "map_styles"
    t.float    "overview_map_lat"
    t.float    "overview_map_lon"
    t.integer  "overview_map_zoom"
  end

  add_index "sites", ["geographic_context_geometry"], :name => "index_sites_on_geographic_context_geometry", :spatial => true
  add_index "sites", ["name"], :name => "index_sites_on_name"
  add_index "sites", ["status"], :name => "index_sites_on_status"
  add_index "sites", ["url"], :name => "index_sites_on_url"

  create_table "stats", :force => true do |t|
    t.integer "site_id"
    t.integer "visits"
    t.date    "date"
  end

  add_index "stats", ["site_id"], :name => "index_stats_on_site_id"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "count", :default => 0
  end

  create_table "themes", :force => true do |t|
    t.string "name"
    t.string "css_file"
    t.string "thumbnail_path"
    t.text   "data"
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
    t.integer  "organization_id"
    t.string   "role"
    t.boolean  "blocked",                                  :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"

end
