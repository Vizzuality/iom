# Mandatory seeds

User.create :email => 'admin@example.com', :password => 'admin', :password_confirmation => 'admin'
Settings.create

# Env seeds (development)

spain = Country.create :name => 'Spain', :code => 'ES'
usa   = Country.create :name => 'United States', :code => 'US'

valencia = Region.create :name => 'Valencia', :country => spain
madrid   = Region.create :name => 'Madrid',   :country => spain

baltimore = Region.create :name => 'Baltimore', :country => usa
alabama   = Region.create :name => 'Alabama',   :country => usa

o1 = Organization.create :name => 'Org 1'

Cluster.create :name => 'c1'
Cluster.create :name => 'c2'
Cluster.create :name => 'c3'
Cluster.create :name => 'c4'

Sector.create :name => 's1'
Sector.create :name => 's2'
Sector.create :name => 's3'
Sector.create :name => 's4'

Tag.create :name => 'asia'
Tag.create :name => 'africa'
Tag.create :name => 'childhood'
Tag.create :name => 'earthquake'

#create view projects_data as SELECT projects.id, projects.name, projects.description, projects.primary_organization_id, projects.implementing_organization, projects.partner_organizations, projects.cross_cutting_issues, projects.start_date, projects.end_date, projects.budget, projects.target, projects.estimated_people_reached, projects.contact_person, projects.contact_email, projects.contact_phone_number, projects.site_specific_information, projects.created_at, projects.updated_at, projects.the_geom, organizations.id AS organization_id, organizations.name AS organization_name, organizations.description AS organization_description, organizations.budget AS organization_budget, organizations.website, organizations.staff, organizations.twitter AS organization_twitter, organizations.facebook as organization_facebook, organizations.hq_address, organizations.contact_email AS organization_contact_email, organizations.contact_phone_number AS organization_contact_phone_number, organizations.donation_address, organizations.zip_code, organizations.city, organizations.state, organizations.donation_phone_number, organizations.donation_website AS organization_donation_website, organizations.site_specific_information AS organization_site_specific_information, organizations.logo_file_name as organization_logo_file_name, donors.id AS donor_id, donors.name AS donor_name, donors.description AS donor_description, donors.website AS donor_website, donors.twitter AS donor_twitter, donors.facebook AS donor_facebook, donors.contact_person_name, donors.contact_company, donors.contact_person_position, donors.contact_email  AS donor_contact_email, donors.contact_phone_number AS donor_contact_phone_number, donors.logo_file_name AS donor_logo_file_name, donors.site_specific_information AS donor_site_specific_information, donations.amount, donations.date, tags.name AS tag, regions.name AS region, sectors.name AS sector, clusters.name AS cluster, countries_1.name AS country_name, countries_1.code AS country_code, resources.title AS resource_title, resources.url AS resource_url, media_resources.element_type AS media_resource_type, media_resources.picture_file_name AS media_resource_picture_file_name, media_resources.vimeo_url FROM media_resources RIGHT JOIN (resources RIGHT JOIN ((((((sectors RIGHT JOIN ((countries_projects RIGHT JOIN (clusters_projects RIGHT JOIN (projects_tags RIGHT JOIN (projects_sectors RIGHT JOIN (projects_regions RIGHT JOIN projects ON projects_regions.project_id = projects.id) ON projects_sectors.project_id = projects.id) ON projects_tags.project_id = projects.id) ON clusters_projects.project_id = projects.id) ON countries_projects.project_id = projects.id) LEFT JOIN tags ON projects_tags.tag_id = tags.id) ON sectors.id = projects_sectors.sector_id) LEFT JOIN clusters ON clusters_projects.cluster_id = clusters.id) LEFT JOIN regions ON projects_regions.region_id = regions.id) LEFT JOIN countries AS countries_1 ON countries_projects.country_id = countries_1.id) LEFT JOIN (donors RIGHT JOIN donations ON donors.id = donations.donor_id) ON projects.id = donations.project_id) LEFT JOIN organizations ON projects.primary_organization_id = organizations.id) ON resources.element_id = projects.id  AND resources.element_type=0) ON media_resources.element_id = projects.id AND media_resources.element_type=0;
