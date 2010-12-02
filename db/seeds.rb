# Mandatory seeds

User.create :email => 'admin@example.com', :password => 'admin', :password_confirmation => 'admin'
Settings.create

Theme.create :name => 'Yellow', :css_file => '/stylesheets/themes/yellow.css', :thumbnail_path => '/images/backoffice/sites/theme_1.png'
Theme.create :name => 'Pink',   :css_file => '/stylesheets/themes/pink.css',   :thumbnail_path => '/images/backoffice/sites/theme_2.png'
Theme.create :name => 'Blue',   :css_file => '/stylesheets/themes/blue.css',   :thumbnail_path => '/images/backoffice/sites/theme_3.png'

# Env seeds (development)

Cluster.create :name => 'Camp Coordination and Management'
Cluster.create :name => 'Early Recovery'
Cluster.create :name => 'Education'
Cluster.create :name => 'Emergency Telecommunications'
Cluster.create :name => 'Food Security and Agriculture'
Cluster.create :name => 'Health'
Cluster.create :name => 'Logistics'
Cluster.create :name => 'Nutrition'
Cluster.create :name => 'Protection'
Cluster.create :name => 'Shelter and Non-food Items'
Cluster.create :name => 'Water, Sanitation and Hygiene'

Sector.create :name => 'Agriculture'
Sector.create :name => 'Communications'
Sector.create :name => 'Disaster Management'
Sector.create :name => 'Economic Recovery and Development'
Sector.create :name => 'Education'
Sector.create :name => 'Environment'
Sector.create :name => 'Food Aid'
Sector.create :name => 'Health'
Sector.create :name => 'Human Rights, Democracy and Governance'
Sector.create :name => 'Peace and Security'
Sector.create :name => 'Protection'
Sector.create :name => 'Shelter and Housing'
Sector.create :name => 'Water, Sanitation and Hygiene'
Sector.create :name => 'Other'

Tag.create :name => 'asia'
Tag.create :name => 'africa'
Tag.create :name => 'childhood'
Tag.create :name => 'earthquake'



# Sites
#  sites for testing purposes. Add this line to your /etc/hosts:
#  127.0.0.1       iom-haiti.ipq.co
site = Site.create :name => 'Haiti Aid Map', :url => 'iom-haiti.ipq.co', :status => true,
                   :project_context_organization_id => o1.id,
                   :project_context_cluster_id => cluster_water.id,
                   :theme => Theme.find_by_name('Blue')
#  127.0.0.1       iom-food.ipq.co
site = Site.create :name => 'Food Security', :url => 'iom-food.ipq.co', :status => true,
                  :project_context_organization_id => o2.id,
                  :theme => Theme.find_by_name('Yellow')