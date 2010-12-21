# Mandatory seeds

User.create :email => 'admin@example.com', :password => 'admin', :password_confirmation => 'admin'
Settings.create

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
                   :theme => Theme.find_by_name('Garnet')
site.geographic_context_country = Country.find_by_name('Haiti')
site.overview_map_bbox_miny=17.78605726800591;
site.overview_map_bbox_minx=-76.94549560546851;
site.overview_map_bbox_maxy=20.262938421364236;
site.overview_map_bbox_maxx=-69.66705322265601;


site.pages.find_by_title("About").body=
               <<-EOF
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
                    <h2>BENEFITS OF PARTICIPATING</h2>
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

site.pages.find_by_title("Analysis").body = <<-EOF
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

site.save!

#  127.0.0.1       iom-food.ipq.co
site = Site.create :name => 'Food Security', :url => 'iom-food.ipq.co', :status => true,
                   :theme => Theme.find_by_name('Garnet')
                              
site.overview_map_bbox_miny=-65;
site.overview_map_bbox_minx=-170;
site.overview_map_bbox_maxy=70;
site.overview_map_bbox_maxx=170;     


site.save!              

