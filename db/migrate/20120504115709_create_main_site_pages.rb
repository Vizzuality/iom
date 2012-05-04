class CreateMainSitePages < ActiveRecord::Migration
  def self.up
    MainPage.create(
      :title =>  'About NGO Aid Map',
      :body =>  (<<-HTML
        <p>NGO Aid Map is an InterAction initiative focused on collecting information on NGOs' work at the project level and making it accessible to donors, NGOs, businesses, governments and the public through an online, interactive mapping tool. The site, which primarily focuses on the work of InterAction members, aims to:</p>
        <ul>
          <li>Promote transparency</li>
          <li>Facilitate partnerships and improve coordination</li>
          <li>Help guide decisions about where to direct aid resources</li>
          <li>Inform advocacy and influence policy</li>
        </ul>
        <p>Best practices are highlighted in select areas, allowing for information sharing on effective approaches.</p>
        <p>We welcome your feedback and suggestions on NGO Aid Map.  Please email us at <a href="mailto:mappinginfo@interaction.org">mappinginfo@interaction.org</a>.
        </p>
        <h3>FOCUS AREAS</h3>
        <p>Our mapping work is currently focused on:</p>
        <p><a href="http://foodsecurity.ngoaidmap.org">Food Security</a>: With funding from the International Fund for Agricultural Development (IFAD), InterAction has developed Food Security Aid Map to provide detailed project-level information on food security and agriculture projects being done by NGOs and the US NGO Working Group on IFAD and Rural Poverty.</p>
        <p><a href="http://haiti.ngoaidmap.org">Haiti</a>: Since the earthquake in January 2010, InterAction, in partnership with BCLC and with funding from FedEx, has developed a web-based mapping platform to highlight NGOs programs in Haiti.  InterAction has been working closely with its members to develop a data collection system that is flexible and can be deployed in future emergencies.</p>
        <p><a href="http://hornofafrica.ngoaidmap.org">Horn of Africa</a>: In response to the drought crises, InterAction, with funding from FedEx, developed Horn of Africa Aid Map. The map highlights the work of members responding to the crisis, as well as long-term development projects that build resiliency against future crises.</p>


        <h3>BENEFITS OF PARTICIPATING</h3>
        <p>InterAction members who participate in the mapping initiative will have access to a powerful, user-friendly mapping software, <a href="http://www.fortiusone.com/Products-Services/GeoIQ">GeoIQ</a>, at no cost. With this tool, members will be able to:</p>
        <ul>
          <li>Create maps and easily share them with others</li>
          <li>Identify potential partners</li>
          <li>Identify underserved areas or areas with greatest needs</li>
          <li>Overlay project information with relevant statistical information, such as child malnutrition rates</li>
          <li>Analyze large amounts of data</li>
        </ul>
        <h3>HOW TO GET INVOLVED</h3>
        <p>For more information on the mapping initiative, including how your organization can participate, please contact Danielle Heiberg at <a href="mailto:mappinginfo@interaction.org">mappinginfo@interaction.org</a> or 202-552-6576.</p>
        <br><br>
        <a href="http://www.ifad.org/" style="margin:0 50px 0 0" target="_blank"><img alt="IFAD" src="/images/sites/partners/ifad.jpg?1335447899" title="IFAD"></a>
        <a href="http://bclc.uschamber.com/" style="margin:0 50px 0 0" target="_blank"><img alt="BCLC" src="/images/sites/partners/bclc.jpg?1335447899" title="BCLC"></a>
        <a href="http://fedex.com/" target="_blank"><img alt="FexEx" src="/images/sites/partners/fedex.jpg?1335447899" title="FexEx"></a>

        <h3 id="credits">CREDITS</h3>
        <p>Food Security Aid Map photo was provided by Tony Rinaudo, <a href="http://www.worldvision.com.au/">World Vision Australia</a>.</p>
        <p>Haiti Aid Map photo was provided by Jon Warren, <a href="http://www.worldvision.org">World Vision</a>.</p>
        <p>Horn of Africa photo was provided by UN/Stuart Price, <a href="http://www.un.org/en/events/humanitarianday/slideshow.shtml">World Humanitarian Day</a>.</p>
      HTML
      ),
      :published =>  true,
      :order_index => 1
    )

    MainPage.create(
      :title =>  'About InterAction',
      :body =>  (<<-HTML
        <p><a href="http://www.interaction.org">InterAction</a> is the largest alliance&nbsp;of U.S.-based international nongovernmental organizations (NGOs) focused on the world’s poor and most vulnerable people.</p>
        <p>At InterAction, we recognize that our global challenges are interconnected and that we can’t tackle any of them without addressing all of them. That’s why we create a forum for leading NGOs, global thought leaders and policymakers to address our challenges collectively. Leveraging our shared expertise, on-the-ground insights from over 190 member organizations and strategic analyses of the foreign aid budget, we deliver a bold, new agenda to end global poverty and deliver humanitarian aid in every developing country.</p>
        <p>In poor communities throughout the developing world, InterAction members meet people halfway in expanding opportunities and supporting gender equality in education, health care, agriculture, small business and other areas. To forestall or recover from the violence that affects millions of innocent civilians, InterAction exercises leadership in conflict prevention, the peaceful resolution of disputes and peacebuilding initiatives in post-conflict situations.</p>
        <h3>ADDITIONAL INFORMATION</h3>
        <ul>
          <li>To learn more about InterAction and its work, visit <a href="http://www.interaction.org">InterAction’s website</a></li>
          <li><a href="http://www.interaction.org/member-directory-all">Complete list of InterAction members</a></li>
        </ul>
      HTML
      ),
      :published =>  true,
      :order_index =>  2
    )
    MainPage.create(
      :title =>  'About the data',
      :body =>  (<<-HTML
        <p>NGO Aid Map includes two primary sets of information:</p>

        <ul>
          <li>General information on the organizations</li>
          <li>Information on these organizations' projects in two areas: <a href="http://haiti.ngoaidmap.org">Haiti</a> and <a href="http://foodsecurity.ngoaidmap.org">Food Security and Agriculture</a></li>
        </ul>

        <p>Organizational information is collected in an “Organizational Profile Form” and project data in an Excel template tailored for each site. InterAction is looking into ways to automate this process to make the data collection process easier and more sustainable.</p>

        <p>Organizations are provided with a guidance document to help ensure that the information collected is consistent across organizations.</p>
        <p>To learn more about the specific data collected for each site, please visit the <a href="http://foodsecurity.ngoaidmap.org/p/about-the-data">About Data section on Food Security Aid Map</a> and <a href="http://haiti.ngoaidmap.org/p/about-the-data">Haiti Aid Map</a>. </p>
      HTML
      ),
      :published =>  true,
      :order_index =>  3
    )
    MainPage.create(
      :title =>  'NGO Aid Map in the media',
      :body =>  (<<-HTML
        <p>
        </p><ul>
          <li>
            <a href="http://blog.interaction.org/node/201">Bridging Gaps Between Information Islands</a><br>
            AidBuzz, August 2011
        </li>
        <li>
          <a href="http://www.trust.org/alertnet/blogs/technotalk/dare-we-say-information-is-beautiful/">Dare We Say Information is Beautiful</a><br>
        AlertNet, August 2011
        </li>
        <li>
          <a href="http://www.devex.com/en/blogs/full-disclosure/interaction-s-new-ngo-aid-map">InterAction’s New NGO Aid Map</a><br>
        Devex, May 2011
        </li>
        <li>
          <a href="http://www.hunger-undernutrition.org/blog/2011/04/ngos-map-food-projects-as-budgets-tighten-.html">NGOs Map Food Projects as Budgets Tighten</a><br>
        The Hunger and Undernutrition Blog, April 2011
        </li>
        <li>
          <a href="http://www.trust.org/alertnet/blogs/technotalk/mapping-ngo-food-projects-amid-rocketing-prices/">Mapping NGO Food Projects Amid Rocketing Prices</a><br>
        Alertnet, March 2001
        </li>
        <li>
          <a href="http://blog.interaction.org/node/32">The Assumptions Behind Haiti Aid Map</a><br>
        AidBuzz, February 2011
        </li>
        <li>
          <a href="http://www.publishwhatyoufund.org/news/2011/01/haitiaidmap-demonstrates-potential-aid-information/">Haiti Aid Map Demonstrates Potential of Aid Information</a><br>
        Publish What You Fund, January 2011
        </li>
        <li>
          <a href="http://www.globalhealthmagazine.com/guest_blog/haiti_who_what/">Haiti: Who is Doing What Where</a><br>
        Global Health Magazine, January 2011
        </li>
        <li>
          <a href="http://reliefweb.int/node/380291">New Haiti Aid Map Shows Progress of Recovery and Gaps at the One-Year Mark</a><br>
        Relief Web, January 2011
        </li>
        <li>
          <a href="http://www.aidinfo.org/this-is-how-aid-transparency-could-look.html">This is How Aid Transparency Could Look!</a><br>
        Aid info, January 2011
        </li>
        <li>
          <a href="http://www.oregonlive.com/business/index.ssf/2010/09/mercy_corps_teams_up_with_bank.html">Mercy Corps Teams Up With Bank, Telecom in New Haiti Program</a><br>
        The Oregonian, September 2010
        </li>
        <li>
          <a href="http://haitirewired.wired.com/profiles/blogs/haiti-mapping-initiative-to">Haiti Mapping Initiative to Bring Accountability in Recovery</a><br>
        Haiti Rewired, July 2010
        </li>
        <li>
          <a href="http://blog.tonic.com/the-next-big-thing-mapping-recovery-projects-in-haiti-and-beyond/">The Next Big Thing: Mapping Recovery Projects in Haiti and Beyond</a><br>
        Tonic Blog, July 2010
        </li>
        </ul>
        <p></p>
      HTML
      ),
      :published =>  true,
      :order_index =>  4
    )
    MainPage.create(
      :title =>  'Testimonials',
      :body =>  (<<-HTML
        <p>
        </p><p>Read what others have to say about NGO Aid Map:</p>

        <h3>FOOD SECURITY AID MAP</h3>

        <p>“It is a great tool to understand what the donor landscape is and where INGOs are concentrating their efforts. It allows a better understanding on where there are overlaps and who the organizations should be coordinating their work with.” - <em>Anonymous online user</em></p>

        <p>“The depth of the information being displayed will set the bar high for other organizations that are not members of InterAction to supply similar information.” - <em>Anonymous online user</em></p>

        <h3>HAITI AID MAP</h3>

        <p>“The website looks awesome.  It will be a good tool for us in the field to know who else is involved in communities around Haiti.  Good job and I hope this kind of design is done in other areas of the world.” - <em>Aaron Tate, Church World Service</em></p>

        <p>“Congratulations on this great project that will be of great help.” - <em>Ted Kaplan, MD, Cap Haitien Health Network</em></p>

        <p>“We have referred both Agency and NGO clients to use the Aid map as they were reviewing their location options.  We have worked with the map on several occasions if briefing our colleagues, advisors, clients and stakeholders.   I think the Aid Map will prove to be an invaluable tool and template for reporting and illustrating all manners of data that concern funders, agencies and governments.” - <em>John Keller, President, Proteus On-Demand Facilities</em></p>

        <p>“Haiti Aid Map shows the scope of each agency's humanitarian work on the ground, which makes it a valuable tool for transparency and accountability.” - <em>Michael Delaney, Director of Humanitarian Response, Oxfam America</em></p>

        <p>“I've recently come across your Haiti Aid Map and was really impressed with the collection and presentation of data. My organization, the St. Boniface Haiti Foundation, has actually used the map to look up partners and potential partners and get a visual on the lay of the land. It's extremely helpful.” - <em>Alysia Mueller, Communications Officer, St. Boniface Haiti Foundation</em></p>

        <p>“I loved navigating through the site -the data is neatly presented and quite useful in making anyone feel more confident on what is going on in Haiti as well as hopefully help with coordination and partnerships on the ground.” - <em>Holta Trandafili, Design, Monitoring &amp; Evaluation Specialist, World Vision</em></p>

        <p>“Haiti Aid Map is a tool for learning and information sharing.” - <em>Anonymous online user</em></p>

        <p>“Haiti Aid Map helps us better promote our work and the work of others to better coordinate.” - <em>Anonymous online user</em></p>

        <p>“Excellent work. This should be more widely publicized or at least as widely publicized as any Ushahidi platform is so that the world does not only see need, need, need but supply along with it (and I don't mean adding a layer on top of a Ushahidi deployment). How about collaborating with all the clusters and creating this in every response in the world big or small?” - <em>Anonymous user</em></p>

        <p>“Haiti Aid Map helps us streamline multiple requests for data on our projects. We refer these inquiries to the InterAction map.” - <em>Anonymous online user</em></p>






                <p></p>
      HTML
      ),
      :published =>  true,
      :order_index =>  5
    )
    MainPage.create(
      :title =>  'Link to NGO Aid Map',
      :body =>  (<<-HTML
        <p>We encourage you to share your work through NGO Aid Map. InterAction has created buttons which you can use to link to your organization’s page on Haiti Aid Map and/or Food Security Aid Map through your own website.  </p>
        <p>
          <a class="button" href="/images/sites/home/ngo_button.gif"><img src="/images/sites/home/ngo_button.gif"></a><br>
          <a class="button" href="/images/sites/home/haiti_button.gif"><img src="/images/sites/home/haiti_button.gif"></a><br>
          <a class="button" href="/images/sites/home/food_button.gif"><img src="/images/sites/home/food_button.gif"></a><br>
        </p>
        <h3>Instructions</h3>
          <ul>
            <li> Right click on an image above and copy image location</li>
            <li>Place image on your website</li>
            <li>Hyperlink image to your organization's page on Haiti Aid Map or Food Security Aid Map</li>
          </ul>

        <p>Having trouble downloading/using the buttons? Contact us at <a href="mailto:mappinginfo@interaction.org">mappinginfo@interaction.org</a></p>
      HTML
      ),
      :published =>  true,
      :order_index =>  6
    )
    MainPage.create(
      :title =>  'Make your own map',
      :body =>  (<<-HTML
        <h3>Make a Map Using GeoIQ</h3>
        <img src="/images/sites/home/logo-geoiq.gif">
        <p><a href="http://www.geoiq.com">GeoIQ</a> is a geospatial data management, visualization and analysis platform allowing both technical and non-technical users access to a collaborative, browser-based tool. This flexible platform accepts a variety of file types and employs an intuitive file storage system that can be organized by tags for faster, accurate searches and allows users to create a variety of maps with multiple layers for a unique perspective on data.

        </p><h3>What kind of data is available?</h3>
        <p>Using GeoIQ, users can also seamlessly access GeoCommons, a public community of GeoIQ users and repository consisting of over 50,000 importable datasets and maps. In addition to the data included in the GeoCommons repository, InterAction’s Enterprise package of GeoIQ includes a selection of shapefiles covering over <a href="#countries_list">70 countries</a>, and <a href="#indicators">national level indicators</a> from credible sources covering a variety of topics and issue areas. New and other relevant datasets will continue to be added in the future.</p>

        <h3>Request a License</h3>
        <p>InterAction members actively participating (i.e. providing data) in the NGO Aid Map initiative are eligible to receive up to one license at no cost. To request a license, send us an e-mail at <a href="mailto:mappinginfo@interaction.org">mappinginfo@interaction.org</a> with “GeoIQ License Request” in the subject line and the following information:</p>

        <ul>
          <li>Primary User Full Name</li>
          <li>Title</li>
          <li>Organization</li>
          <li>E-mail Address</li>
        </ul>

        <p>Upon receipt of this information, you will receive your log-in credentials via e-mail within 24 hours. If additional information is required, a member of the mapping team will contact you via e-mail. If you are a non-member / non-participating organization, please visit the GeoCommons website at <a href="http://www.geocommons.com">http://www.geocommons.com </a> to access the public version.</p>

        <h3>Already Have A License?</h3>
        <p><a href="http://ngoquest.org/">Sign into geoIQ</a></p>

        <h3>Not an InterAction Member?</h3>
        <p><a href="http://www.interaction.org/get-involved">Get involved</a>.</p>

        <h3>Trainings Overview</h3>
        <p>We offer informal trainings upon request to member organizations and interested staff. Our training will include a general overview of GeoIQ and short tutorials on ways to visualize your data using a selection of datasets and maps.</p>

        <p>Topics covered in trainings will include:</p>

        <ul>
          <li>Overview of GeoIQ</li>
          <li>Basics of Preparing you Datasets &amp; Acceptable File Types</li>
          <li>Geocoding &amp; Georeferencing</li>
          <li>Creating Reference Maps</li>
          <li>Creating Thematic Maps</li>
          <li>Charts &amp; Graphs</li>
          <li>Sharing &amp; Embedding</li>
        </ul>

        <h3>Schedule a Training Session</h3>

        <p>We are happy to conduct a training session for you and interested staff in your organization. GeoIQ trainings are mostly conducted over webinar. In order to successfully attend a training session, you will need a computer, working internet connection and access to a telephone line. We are also happy to conduct in-person trainings for our members in the Washington, D.C metropolitan area.</p>

        <p>Due to limited staff capacity, we encourage you to reach out to us at least 1-2 weeks in advance of your desired date/time for training. To schedule a training session, please send us an e-mail at <a href="mailto:mappinginfo@interaction.org">mappinginfo@interaction.org</a>.</p>

        <h3>Feedback</h3>

        <p>Your feedback on GeoIQ is very important to our ongoing work and that of the NGO Aid Map initiative. Please share your experiences and ideas for improvement with us at <a href="mailto:mappinginfo@interaction.org">mappinginfo@interaction.org</a>.</p>

        <h3>Country 1st Administrative Division Shapefiles</h3>

        <div id="countries_list" class="threecols">
        <ul>
        <li>Afghanistan</li>
        <li>Albania</li>
        <li>Angola</li>
        <li>Armenia</li>
        <li>Bangladesh</li>
        <li>Belize</li>
        <li>Benin</li>
        <li>Bolivia</li>
        <li>Brazil</li>
        <li>Burkina Faso</li>
        <li>Burundi</li>
        <li>Cambodia</li>
        <li>Cameroon</li>
        <li>Chad</li>
        <li>Chile</li>
        <li>China</li>
        <li>Colombia</li>
        <li>Costa Rica</li>
        <li>Democratic Republic of Congo</li>
        <li>Dominican Republic</li>
        <li>Ecuador</li>
        <li>El Salvador</li>
        <li>Ethiopia</li>
        <li>Ghana</li>
        </ul>
        <ul>
        <li>Guatemala</li>
        <li>Guinea-Bissau</li>
        <li>Haiti</li>
        <li>Honduras</li>
        <li>India</li>
        <li>Indonesia</li>
        <li>Iraq</li>
        <li>Jordan</li>
        <li>Kenya</li>
        <li>Laos</li>
        <li>Lebanon</li>
        <li>Lesotho</li>
        <li>Liberia</li>
        <li>Madagascar</li>
        <li>Malawi</li>
        <li>Mali</li>
        <li>Mauritania</li>
        <li>Mexico</li>
        <li>Mozambique</li>
        <li>Myanmar (Burma)</li>
        <li>Nepal</li>
        <li>Nicaragua</li>
        <li>Niger</li>
        <li>Nigeria</li>
        </ul>
        <ul class="last">
        <li>Peru</li>
        <li>Philippines</li>
        <li>Romania</li>
        <li>Rwanda</li>
        <li>Senegal</li>
        <li>Sierra Leone</li>
        <li>Solomon Islands</li>
        <li>Somalia</li>
        <li>South Africa</li>
        <li>Sri Lanka</li>
        <li>Sudan</li>
        <li>Swaziland</li>
        <li>Syria</li>
        <li>Tanzania</li>
        <li>Thailand</li>
        <li>Gambia</li>
        <li>Uganda</li>
        <li>Uruguay</li>
        <li>Vanuatu</li>
        <li>Vietnam</li>
        <li>West Bank and Gaza</li>
        <li>Zambia</li>
        <li>Zimbabwe</li>
        </ul>
        </div>

        <p>Note: Country shapefiles listed above are based on information obtained from the GADM database of Global Administrative Areas. These boundaries and names do not imply official endorsement or acceptance by InterAction.</p>

        <h3>National Indicators</h3>

        <div id="indicators" class="threecols">
        <ul>
        <li>Percentage Agriculture Land</li>
        <li>Agricultural Population Density</li>
        <li>Proportion of Poor</li>
        <li>GEF Benefits Index for Biodiversity</li>
        <li>Percentage of Low Birth-weight Infants</li>
        <li>Gini Index</li>
        </ul>

        <ul>
        <li>Percent of Women in National Parliaments</li>
        <li>Depth of Hunger</li>
        <li>Access to Improved Sanitation Services</li>
        <li>Life Expectancy</li>
        <li>Commercial Bank Accounts</li>
        <li>Livestock Production Index</li>
        </ul>
        <ul class="last">
        <li>Multi-dimensional Poverty Index</li>
        <li>Agriculture Value Added (% of GDP)</li>
        <li>Total Population</li>
        <li>Female Economically Active Population in Agriculture</li>
        <li>Arable Land</li>
        </ul>

        </div>
      HTML
      ),
      :published =>  true,
      :order_index =>  7
    )
    MainPage.create(
      :title =>  'Frequently Asked Questions',
      :body =>  (<<-HTML
        <p class="question" id="firstquestion">What is NGO Aid Map?</p>

        <p>NGO Aid Map is an InterAction initiative that provides detailed information on our members’ work through a web-based mapping platform. The initiative currently focuses on two areas: <a href="http://haiti.ngoaidmap.org">Haiti</a> and <a href="http://foodsecurity.ngoaidmap.org">Food Security and Agriculture</a>.</p>

        <p class="question">What is its purpose?</p>
        <p>By making information on NGO activities easily accessible, NGO Aid Map strives to: </p>
        <ul>
          <li>Increase transparency within the NGO community </li>
          <li>Facilitate partnerships and improve coordination among NGOs, private sector, governments and donors</li>
          <li>Help NGOs and others involved in relief and development make more informed decisions about where to direct their resources</li>
        </ul>

        <p class="question">What information is available on the site?</p>
        <p>NGO Aid Map includes two primary kinds of information:</p>
        <ul>
          <li>General information on the organizations </li>
          <li>Information on these organizations’ projects</li>
        </ul>
        <p>To learn more about the data being collected for the site, please see <a href="/about-data">About the data</a>.</p>

<p class="question">Which organizations are represented on this site?</p>
<p>NGO Aid Map features information on the work of non-governmental organizations (NGOs) working in Haiti or food security &amp; agriculture globally, either directly or indirectly through local or international partners. Most of the organizations represented on the site are InterAction members.</p>

<p class="question">Why do some countries have very few or no projects?</p>
<p>This site only contains information InterAction receives from organizations participating in this initiative. A country may have few or no projects for a couple of reasons. Since this initiative focuses on InterAction members and partners, not all organizations are eligible to participate in this initiative (see “Which organizations are represented on the site?”) and thus not represented on the map. Another reason is that those who are eligible have not yet provided information on their work in that country. We will continue to add information to the site when received by eligible organizations.</p>

<p class="question">How often is the information updated?</p>
<p>The site is updated periodically throughout the year, although organizations may provide updates at any time.</p>

<p class="question">Is the data on the site vetted?</p>
<p>No. InterAction relies on its members and other participating organizations to provide accurate and complete information on their work. While we cannot independently verify the information submitted, InterAction does review the data to check for inconsistencies, codes the data by sector and follows up with organizations as needed to ensure that their information is as complete as possible.</p>

<p class="question">How can organizations participate in the NGO Aid Map?</p>
<p>Due to our limited capacity, InterAction is focusing its data collection on members and their NGO partners at this time. If your organization meets this criterion and would like to submit information for this initiative, please send us an email at <a href="mailto:mappinginfo@interaction.org">mappinginfo@interaction.org</a>.</p>

      HTML
      ),
      :published =>  true,
      :order_index =>  8
    )
    MainPage.create(
      :title =>  'Contact Us',
      :body =>  (<<-HTML
        <p>If you have any questions or would like to learn more about NGO Aid Map or any sub-sites, please contact us and a member of InterAction’s mapping team will contact you promptly.</p>
        <ul>
          <li><a href="mailto:mappinginfo@interaction.org">General Information</a>, tel: (202) 552-6572</li>
          <li><a href="mailto:jmontgom@interaction.org">Julie Montgomery</a>, Project Manager</li>
          <li><a href="mailto:lgrino@interaction.org">Laia Grino</a>, Data Manager</li>
          <li><a href="mailto:dheiberg@interaction.org">Danielle Heiberg</a>, Outreach &amp; Communications</li>
          <li><a href="mailto:sramachandran@interaction.org">Sivaram Ramachandran</a>, Data Coordinator</li>
        </ul>
        <p>We welcome your feedback. InterAction would also like to hear from you if:</p>
        <ul>
          <li>Your organization would like to learn more about or participate in our mapping initiative.</li>
          <li>You have thoughts on how to make NGO Aid Map or one of our sub-sites more useful. What questions should these sites help answer? What type of information should we highlight? What other features would you like to see?</li>
        </ul>
        <p>Any other feedback is welcome.</p>
      HTML
      ),
      :published =>  true,
      :order_index =>  9
    )
  end

  def self.down
    MainPage.destroy_all
  end
end
