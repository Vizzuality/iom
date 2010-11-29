# Mandatory seeds

User.create :email => 'admin@example.com', :password => 'admin', :password_confirmation => 'admin'
Settings.create

Theme.create :name => 'Yellow', :css_file => '/stylesheets/themes/yellow.css', :thumbnail_path => '/images/backoffice/sites/theme_1.png'
Theme.create :name => 'Pink',   :css_file => '/stylesheets/themes/pink.css',   :thumbnail_path => '/images/backoffice/sites/theme_2.png'
Theme.create :name => 'Blue',   :css_file => '/stylesheets/themes/blue.css',   :thumbnail_path => '/images/backoffice/sites/theme_3.png'

# Env seeds (development)
spain = Country.create :name => 'Spain', :code => 'ES'
usa   = Country.create :name => 'United States', :code => 'US'

valencia = Region.create :name => 'Valencia', :country => spain
madrid   = Region.create :name => 'Madrid',   :country => spain

baltimore = Region.create :name => 'Baltimore', :country => usa
alabama   = Region.create :name => 'Alabama',   :country => usa

# Organizations
o1 = Organization.create  :name => "Intermon Oxfam",
                          :description => "Oxfam America is an international relief and development organization that creates lasting solutions to poverty, hunger, and injustice. Together with individuals and local groups in more than 90 countries, Oxfam saves lives, helps people overcome poverty, and fights for social justice. We are one of the 14 affiliates in the international confederation, Oxfam.",
                          :budget => 250000000,
                          :website => "http://www.oxfamamerica.org",
                          :staff => 1432,
                          :twitter => "oxfamamerica",
                          :facebook => "http://www.facebook.com/oxfamamerica",
                          :hq_address => "Oxfam St, 32, City Center",
                          :contact_email => "contact_intermon_oxfam@example.com",
                          :contact_phone_number => "+31 2321 2133",
                          :donation_address => "Donation Address Intermon Oxfam, 232, City Center",
                          :zip_code => "UA23",
                          :city => "New York",
                          :state => "New York",
                          :donation_phone_number => "+32 231 11 11 11",
                          :donation_website => "http://www.oxfamamerica.org/donations",
                          :site_specific_information => nil,
                          :international_staff => "international staff",
                          :contact_name => "Steve Balmer",
                          :contact_position => "Intermon contact CEO",
                          :contact_zip => "123",
                          :contact_city => "Atlanta",
                          :contact_state => "Maryland",
                          :contact_country => "United States",
                          :donation_country => "United States"

o2 = Organization.create  :name => "Caritas org",
                          :description => "Description for caritas",
                          :budget => 10000,
                          :website => "http://www.caritas.es/",
                          :staff => 500,
                          :twitter => "caritas",
                          :facebook => "www.facebook.com/caritas",
                          :hq_address => "Caritas St, 32, City Center",
                          :contact_email => "contact_caritas@example.com",
                          :contact_phone_number => "+31 123 2133",
                          :donation_address => "Donation Address Caritas, 232, City Center",
                          :zip_code => "AB123",
                          :city => "Madrid",
                          :state => "Madrid",
                          :donation_phone_number => "+32 231 11 11 11",
                          :donation_website => "http://www.caritas.es/donations",
                          :site_specific_information => nil,
                          :international_staff => "international staff",
                          :contact_name => "Steve Caritas",
                          :contact_position => "Caritas contact CEO",
                          :contact_zip => "28005",
                          :contact_city => "Madrid",
                          :contact_state => "Madrid",
                          :contact_country => "Spain",
                          :donation_country => "Spain"

cluster_health = Cluster.create :name => 'Health'
cluster_water = Cluster.create :name => 'Water'
cluster_food_security = Cluster.create :name => 'Food Security'
cluster_floods = Cluster.create :name => 'Floods'

Sector.create :name => 'food sector'
Sector.create :name => 'health sector'

Tag.create :name => 'asia'
Tag.create :name => 'africa'
Tag.create :name => 'childhood'
Tag.create :name => 'earthquake'

# Projects

p1 = Project.create :name => "Food Conservation",
                    :description => "Food Conservation is a project .....",
                    :primary_organization => o1,
                    :tags => "asia, childhood",
                    :implementing_organization => o1.try(:name),
                    :cross_cutting_issues => 'Issues defined',
                    :start_date => Date.today.yesterday,
                    :end_date => Date.today + 1.month,
                    :budget => 250000,
                    :target => 'Farmers',
                    :estimated_people_reached => 12312,
                    :contact_person => 'The Farmer',
                    :contact_email => 'food_conservation@example.com',
                    :contact_phone_number => '0031 345 03 23',
                    :the_geom => MultiPoint.from_points([Point.from_lon_lat(-3.726489543914795, 40.453423411115494),  Point.from_lon_lat(-3.7259557843208313, 40.45303562320312), Point.from_lon_lat(3.726789951324463, 40.44353412028846)]),
                    :intervention_id => 'i-12312312',
                    :additional_information => "This is the extra information for this project...",
                    :awardee_type => 'Type of awardee #1'

p1.clusters << cluster_floods
p1.clusters << cluster_water
p1.regions  << valencia
p1.regions  << madrid

p2 = Project.create :name => "Vegetable generation",
                    :description => "Vegetable generation is a project ....",
                    :primary_organization => o1,
                    :tags => "childhood, earthquake",
                    :implementing_organization => o1.try(:name),
                    :cross_cutting_issues => 'Issues defined for vegetables',
                    :start_date => Date.today.yesterday,
                    :end_date => Date.today + 3.month,
                    :budget => 100,
                    :target => 'Fishers',
                    :estimated_people_reached => 12312,
                    :contact_person => 'The vegetable maker',
                    :contact_email => 'vegetable_generation@example.com',
                    :contact_phone_number => '0031 345 03 23',
                    :the_geom => MultiPoint.from_points([Point.from_lon_lat(-3.726489543914795, 40.453423411115494),  Point.from_lon_lat(-3.7259557843208313, 40.45303562320312), Point.from_lon_lat(3.726789951324463, 40.44353412028846)]),
                    :intervention_id => 'i-33333',
                    :additional_information => "This is the extra information for this project...",
                    :awardee_type => 'Type of awardee #2'

p2.clusters << cluster_water
p2.regions  << madrid
p3 = Project.create :name => "Fishing",
                    :description => "Fishing generation is a project ....",
                    :primary_organization => o2,
                    :tags => "earthquake",
                    :implementing_organization => o2.try(:name),
                    :cross_cutting_issues => 'Issues defined for fishing',
                    :start_date => Date.today.yesterday,
                    :end_date => Date.today + 3.month,
                    :budget => 100,
                    :target => 'Fishers',
                    :estimated_people_reached => 12312,
                    :contact_person => 'The fishing maker',
                    :contact_email => 'fishing_generation@example.com',
                    :contact_phone_number => '0031 345 03 23',
                    :the_geom => MultiPoint.from_points([Point.from_lon_lat(-3.726489543914795, 40.453423411115494),  Point.from_lon_lat(-3.7259557843208313, 40.45303562320312), Point.from_lon_lat(3.726789951324463, 40.44353412028846)]),
                    :intervention_id => 'i-22222',
                    :additional_information => "This is the extra information for this project...",
                    :awardee_type => 'Type of awardee #3'

# Donors & donations
donor = Donor.create  :name => "Fernando Blat",
                      :description => "Fernando Blat has decide to be a donor in this project.",
                      :website => "http://www.blatsoft.org/donors",
                      :twitter => "blatsoft",
                      :facebook => "www.facebook.com/blatsfot",
                      :contact_person_name => "Fernando Blat",
                      :contact_company => "Blatsoft",
                      :contact_person_position => "BlatSoft CTO",
                      :contact_email => "blat@example.com",
                      :contact_phone_number => "+31 2321 2133",
                      :site_specific_information => nil

donor.donations.create :project => p1, :amount => 1000
donor.donations.create :project => p1, :amount => 2000
donor.donations.create :project => p1, :amount => 3000
donor.donations.create :project => p3, :amount =>  500

# Sites
#  sites for testing purposes. Add this line to your /etc/hosts:
#  127.0.0.1       www.haitiaidmap.com haitiadimap.com
site = Site.create :name => 'Haiti Aid Map', :url => 'www.haitiaidmap.com', :status => true,
                   :project_context_organization_id => o1.id,
                   :project_context_cluster_id => cluster_water.id,
                   :theme => Theme.find_by_name('Blue')