# -*- coding: utf-8 -*-
# Mandatory seeds

User.create :name => 'admin', :email => 'admin@example.com', :password => 'admin', :password_confirmation => 'admin', :role => 'admin'



settings = Settings.find_or_create_by_id(1)
data = HashWithIndifferentAccess.new
data[:main_site_host] = 'ngoaidmap.dev'
settings.data = data
settings.save!


Theme.create :name => 'Garnet',
             :css_file => '/stylesheets/themes/garnet.css',
             :thumbnail_path => '/images/themes/1/thumbnail.png',
             :data => {
               :overview_map_chco => "F7F7F7,8BC856,336600",
               :overview_map_chf => "bg,s,2F84A3",
               :overview_map_marker_source => "/images/themes/1/",
               :georegion_map_chco => "F7F7F7,8BC856,336600",
               :georegion_map_chf => "bg,s,2F84A3",
               :georegion_map_marker_source => "/images/themes/1/",
               :georegion_map_stroke_color => "#000000",
               :georegion_map_fill_color => "#000000"
             }

Theme.create :name => 'Pink',
             :css_file => '/stylesheets/themes/pink.css',
             :thumbnail_path => '/images/themes/2/thumbnail.png',
             :data => {
               :overview_map_chco => "F7F7F7,8BC856,336600",
               :overview_map_chf => "bg,s,2F84A3",
               :overview_map_marker_source => "/images/themes/2/",
               :georegion_map_chco => "F7F7F7,8BC856,336600",
               :georegion_map_chf => "bg,s,2F84A3",
               :georegion_map_marker_source => "/images/themes/2/",
               :georegion_map_stroke_color => "#000000",
               :georegion_map_fill_color => "#000000"
             }

Theme.create :name => 'Blue',
             :css_file => '/stylesheets/themes/blue.css',
             :thumbnail_path => '/images/themes/3/thumbnail.png',
             :data => {
               :overview_map_chco => "F7F7F7,8BC856,336600",
               :overview_map_chf => "bg,s,2F84A3",
               :overview_map_marker_source => "/images/themes/3/",
               :georegion_map_chco => "F7F7F7,8BC856,336600",
               :georegion_map_chf => "bg,s,2F84A3",
               :georegion_map_marker_source => "/images/themes/3/",
               :georegion_map_stroke_color => "#000000",
               :georegion_map_fill_color => "#000000"
             }

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
Cluster.create :name => 'Shelter and Non-Food Items'
Cluster.create :name => 'Water Sanitation and Hygiene'

Sector.create :name => 'Agriculture'
Sector.create :name => 'Communications'
Sector.create :name => 'Disaster Management'
Sector.create :name => 'Economic Recovery and Development'
Sector.create :name => 'Education'
Sector.create :name => 'Environment'
Sector.create :name => 'Food Aid'
Sector.create :name => 'Health'
Sector.create :name => 'Human Rights Democracy and Governance'
Sector.create :name => 'Peace and Security'
Sector.create :name => 'Protection'
Sector.create :name => 'Shelter and Housing'
Sector.create :name => 'Water Sanitation and Hygiene'
Sector.create :name => 'Other'

Tag.create :name => 'asia'
Tag.create :name => 'africa'
Tag.create :name => 'childhood'
Tag.create :name => 'earthquake'



# Sites
#  sites for testing purposes. Add this line to your /etc/hosts:
#  127.0.0.1       dev-haiti.ngoaidmap.dev
site = Site.new :name              => 'Haiti Aid Map',
                :url               => "#{Rails.env.eql?('development') ? 'dev-' : ''}haiti.ngoaidmap.dev",
                :status            => true,
                :project_classification => 1,
                :short_description =>'Mapping efforts to reduce poverty and suffering',
                :long_description  =>'On January 12th 2010, a catastrophic earthquake occured at Haiti, leaving more than 250.000 deaths and more than 1.000.000 homeless people. It was one of the biggest disasters in the century. Since then and until now, a huge effort has been made by some of the interaction members',
                :theme             => Theme.find_by_name('Garnet'),
                :aid_map_image     => File.open(File.join(Rails.root, '/public/images/sites/haiti_img_example.jpg')),
                :navigate_by_level3 => true,
                :google_analytics_id => 'UA-20618946-2'

site.geographic_context_country_id = Country.find_by_name('Haiti').id
# site.overview_map_bbox_miny        = 17.78605726800591
# site.overview_map_bbox_minx        = -76.94549560546851
# site.overview_map_bbox_maxy        = 20.262938421364236
# site.overview_map_bbox_maxx        = -69.66705322265601
site.word_for_regions="Communes"


site.save!

site.pages.find_by_title('About').update_attribute(:body, <<-HTML
                    <p><a href="/">InterAction</a> is developing a web-based mapping platform and database that will ultimately map all of our members’
                    work worldwide. In 2010, InterAction will pilot the mapping platform with a focus on the NGO community’s response to the earthquake
                    in Haiti, as well as its efforts to improve food security in various countries around the world.</p>
                    <p>The mapping platform will be an effective, flexible and sustainable means of capturing information on NGO activities that will:</p>
                    <ul>
                      <li>Demonstrate NGOs’ commitment to transparency and accountability</li>
                      <li>Facilitate partnerships and improve coordination among humanitarian actors</li>
                      <li>Help NGOs and other actors make more informed decisions about where to direct resources</li>
                      <li>Highlight the global reach of NGOs to donors, the media and public</li>
                    </ul>
                    <h3>BENEFITS OF PARTICIPATING</h3>
                    <p>InterAction members who participate in the mapping initiative will have access to a powerful, user-friendly mapping software, GeoIQ, at no cost. With this tool, members will be able to:</p>
                    <ul>
                      <li>Create maps and easily share them with others</li>
                      <li>Identify potential partners</li>
                      <li>Identify underserved areas or areas with greatest needs</li>
                      <li>Access more than 20,000 data sets from organizations such as the United Nations or World Bank</li>
                      <li>Overlay project information with relevant statistical information, such as child malnutrition rates</li>
                      <li>Analyze large amounts of data</li>
                    </ul>
               HTML
)
site.pages.find_by_title('Highlights').update_attribute(:body, <<-HTML
                   <p>On October 21, the Government of Haiti confirmed an outbreak of cholera, an acute and highly contagious diarrheal disease caused
                   by eating or drinking contaminated food or water. Unless immediately treated, cholera can be fatal. As of November 16 Haiti’s Ministry of
                   Health has confirmed 1,039 deaths and 16,799 hospitalized cases.</p>

                   <p>The Haitian Government, UN and NGOs have responded quickly to the epidemic. We have provided treatment to those affected, strengthened health
                   care centers so they are ready to respond, and attempted to prevent the further spread of the disease by distributing clean water and food and promoting good hygiene practices.
                   The provision of safe water and sanitation is critical to reducing the impact of cholera.</p>

                   <p>This map provides information on the number of water and sanitation projects established by InterAction members prior to the cholera outbreak.
                   Departments that have been directly affected by cholera are shaded in red, with darker shades indicating higher number of deaths and departments with no cases (in green).</p>

                   <p>For general information on how InterAction members are responding to the outbreak, please visit the Cholera Outbreak Crisis Response
                  List on InterAction’s website. For specific examples of members’ response please visit the Member Response to Cholera in Haiti map.</p>

                   <p>Source: Ministere de la Sante Publique et de la Population (MSPP) - November 16, 2010</p>
              HTML
)

#  127.0.0.1       dev-food.ngoaidmap.dev
site = Site.new :name => 'Food Security',
                :url => "#{Rails.env.eql?('development') ? 'dev-' : ''}food.ngoaidmap.dev",
                :status => true,
                :project_classification => 1,
                :short_description => 'Food security refers to the availability of food and one’s access to it',
                :long_description => 'The Special Programme for Food Security (SPFS) helps governments replicate successful food security practices on a national scale. The SPFS also encourages investment in rural infrastructure, off-farm income generation, urban agriculture and safety nets',
                :theme => Theme.find_by_name('Garnet'),
                :aid_map_image => File.open(File.join(Rails.root, '/public/images/sites/food_img_example.jpg')),
                :navigate_by_country => true,
                :navigate_by_level1 => true

# site.overview_map_bbox_miny = -65
# site.overview_map_bbox_minx = -170
# site.overview_map_bbox_maxy = 70
# site.overview_map_bbox_maxx = 170

site.word_for_regions="Country"

site.save!

site.pages.find_by_title('About').update_attribute(:body, <<-EOF
                   <p><a href="/">InterAction</a> is developing a web-based mapping platform and database that will ultimately map all of our members’
                   work worldwide. In 2010, InterAction will pilot the mapping platform with a focus on the NGO community’s response to the earthquake
                   in Haiti, as well as its efforts to improve food security in various countries around the world.</p>
                   <p>The mapping platform will be an effective, flexible and sustainable means of capturing information on NGO activities that will:</p>
                   <ul>
                     <li>Demonstrate NGOs’ commitment to transparency and accountability</li>
                     <li>Facilitate partnerships and improve coordination among humanitarian actors</li>
                     <li>Help NGOs and other actors make more informed decisions about where to direct resources</li>
                     <li>Highlight the global reach of NGOs to donors, the media and public</li>
                   </ul>
                   <h3>BENEFITS OF PARTICIPATING</h3>
                   <p>InterAction members who participate in the mapping initiative will have access to a powerful, user-friendly mapping software, GeoIQ, at no cost. With this tool, members will be able to:</p>
                   <ul>
                     <li>Create maps and easily share them with others</li>
                     <li>Identify potential partners</li>
                     <li>Identify underserved areas or areas with greatest needs</li>
                     <li>Access more than 20,000 data sets from organizations such as the United Nations or World Bank</li>
                     <li>Overlay project information with relevant statistical information, such as child malnutrition rates</li>
                     <li>Analyze large amounts of data</li>
                   </ul>
              EOF
)
site.pages.find_by_title('Highlights').update_attribute(:body, <<-EOF
                  <p>On October 21, the Government of Haiti confirmed an outbreak of cholera, an acute and highly contagious diarrheal disease caused
                  by eating or drinking contaminated food or water. Unless immediately treated, cholera can be fatal. As of November 16 Haiti’s Ministry of
                  Health has confirmed 1,039 deaths and 16,799 hospitalized cases.</p>

                  <p>The Haitian Government, UN and NGOs have responded quickly to the epidemic. We have provided treatment to those affected, strengthened health
                  care centers so they are ready to respond, and attempted to prevent the further spread of the disease by distributing clean water and food and promoting good hygiene practices.
                  The provision of safe water and sanitation is critical to reducing the impact of cholera.</p>

                  <p>This map provides information on the number of water and sanitation projects established by InterAction members prior to the cholera outbreak.
                  Departments that have been directly affected by cholera are shaded in red, with darker shades indicating higher number of deaths and departments with no cases (in green).</p>

                  <p>For general information on how InterAction members are responding to the outbreak, please visit the Cholera Outbreak Crisis Response
                 List on InterAction’s website. For specific examples of members’ response please visit the Member Response to Cholera in Haiti map.</p>

                  <p>Source: Ministere de la Sante Publique et de la Population (MSPP) - November 16, 2010</p>
             EOF
)
