namespace :iom do
  namespace :data do
    desc "Load organizations and projects data"
    task :all => %w(load_orgs load_projects)

    desc 'Load organizations data'
    task :load_orgs => :environment do
      DB = ActiveRecord::Base.connection
      DB.execute 'DELETE FROM organizations'
      #The haitiAidMap must be already created and it has ID=1

      csv_orgs = CsvMapper.import("#{Rails.root}/db/data/organizations_20_10_10.csv") do
        read_attributes_from_file
      end
      csv_orgs.each do |row|
        o = Organization.new
        puts row.organization
        o.name                    = row.organization
        o.website                 = row.website
        o.description             = row.about
        o.international_staff     = row.international_staff
        o.contact_name            = row.us_contact_name
        o.contact_position        = row.title
        o.contact_phone_number    = row.us_contact_phone
        o.contact_email           = row.email
        o.donation_address        = [row.donation_address_line_1,row.address_line_2].join("\n")
        o.city                    = row.city
        o.state                   = row.state
        o.zip_code                = row.zip_code
        o.donation_phone_number   = row.donation_phone_number
        o.donation_website        = row.donation_website
        o.estimated_people_reached= row.calculation_of_number_of_people_reached

        o.private_funding         = row.private_funding.to_money.dollars unless (row.private_funding.blank?)
        o.usg_funding             = row.usg_funding.to_money.dollars unless (row.usg_funding.blank?)
        o.other_funding           = row.other_funding.to_money.dollars unless (row.other_funding.blank?)

        budget=0
        budget = o.private_funding unless o.private_funding.nil?
        budget = budget + o.usg_funding  unless o.usg_funding.nil?
        budget = budget + o.other_funding  unless o.other_funding.nil?
        o.budget                  = budget unless budget==0


        o.private_funding_spent   = row.private_funding_spent.to_money.dollars unless (row.private_funding_spent.blank?)
        o.usg_funding_spent       = row.usg_funding_spent.to_money.dollars unless (row.usg_funding_spent.blank?)
        o.other_funding_spent     = row.other_funding_spent.to_money.dollars unless (row.other_funding_spent.blank?)
        o.spent_funding_on_relief = row._spent_on_relief
        o.spent_funding_on_reconstruction = row._spent_on_reconstruction
        o.percen_relief           = row._relief
        o.percen_reconstruction   = row._reconstruction
        o.national_staff          = row.national_staff
        o.media_contact_name      = row.media_contact_name
        o.media_contact_position  = row.media_contact_title
        o.media_contact_phone_number = row.media_contact_phone
        o.media_contact_email     = row.media_contact_email


        #Site specific attributes for Haiti
        o.attributes_for_site = {:organization_values => {:description=>row.organizations_work_in_haiti}, :site_id => 1}
        o.save!
        #puts row.organization
      end

    end
    desc 'Load projects data'
    task :load_projects  => :environment do
      DB = ActiveRecord::Base.connection
      DB.execute 'DELETE FROM projects'
      DB.execute 'DELETE FROM countries_projects'
      DB.execute 'DELETE FROM projects_sectors'
      DB.execute 'DELETE FROM clusters_projects'
      DB.execute 'DELETE FROM organizations_projects'
      DB.execute 'DELETE FROM donations'
      DB.execute 'DELETE FROM donors'

      #Cache geocoding
      geo_cache={}

      csv_projs = CsvMapper.import("#{Rails.root}/db/data/projects_20_10_10.csv") do
        read_attributes_from_file
      end
      csv_projs.each do |row|
        p = Project.new
        o = Organization.find_by_name(row.organization)
        if o
          puts "PROJECT FOR: #{o.id}"
          p.primary_organization = o
          p.intervention_id           = row.ipc
          p.name                      = row.interv_title
          p.description               = row.interv_description
          p.activities                = row.interv_activities
          p.additional_information     = row.additional_information

          p.start_date = Date.strptime(row.est_start_date_mmddyyyy, '%m/%d/%Y') unless (row.est_start_date_mmddyyyy.blank?)
          if(row.est_end_date_mmddyyyy=="2/29/2010")
            row.est_end_date_mmddyyyy="3/1/2010"
          end
          p.end_date = Date.strptime(row.est_end_date_mmddyyyy, '%m/%d/%Y') unless (row.est_end_date_mmddyyyy.blank? or row.est_end_date_mmddyyyy=="Ongoing")

          p.budget                    = row.budget_usd.to_money.dollars unless (row.budget_usd.blank?)
          p.cross_cutting_issues      = row.crosscutting_issues
          p.implementing_organization = row.implementing_organizations
          p.partner_organizations     = row.partner_organizations
          p.estimated_people_reached  = row.number_of_people_reached_target
          p.target                    = row.target_groups
          p.contact_person            = row.contact_name
          p.contact_position          = row.contact_title
          p.contact_email             = row.contact_email
          p.website                   = row.website
          p.date_provided             = Date.strptime(row.date_provided_mmddyyyy, '%m/%d/%Y') unless (row.date_provided_mmddyyyy.blank?)
          p.date_updated              = Date.strptime(row.date_updated_mmddyyyy, '%m/%d/%Y') unless (row.date_updated_mmddyyyy.blank?)


          #Relations
          # -->Clusters
          if(!row.clusters.blank?)
            parsed_clusters = row.clusters.split(",").map{|e|e.strip}
            parsed_clusters.each do |clus|
              p.clusters << Cluster.find_or_create_by_name(:name=>clus)
            end
          end

          # -->Sectors
          # they come separated by commas
          if(!row.ia_sectors.blank?)
            parsed_sectors = row.ia_sectors.split(",").map{|e|e.strip}
            parsed_sectors.each do |sec|
              p.sectors << Sector.find_or_create_by_name(:name=>sec)
            end
          end

          # -->Donor
          if(!row.donors.blank?)
            parsed_donors = row.donors.split(",").map{|e|e.strip}
            parsed_donors.each do |don|
              donor = Donor.find_or_create_by_name(:name=>don)
              donation = Donation.new
              donation.project = p
              donation.donor = donor
              p.donations << donation
            end
          end

          # -->Country
          if (!row.country.blank?)
            country = Country.find_or_create_by_name(:name=>row.country)
            p.countries  << country
          end


          #Geo data
          multi_point=""
          if(!row._3rd_administrative_level_commune.blank?)
            parsed_adm3 = row._3rd_administrative_level_commune.split(",").map{|e|e.strip}
            locations = Array.new
            parsed_adm3.each do |region_name|
              reg = Region.find_or_create_by_name(:name=>region_name)
              reg.country = country
              reg.save!
              p.regions  << reg

              #georef
              if(geo_cache[region_name].blank?)
                loc = Geokit::Geocoders::GoogleGeocoder.geocode("#{region_name},Haiti")
                geo_cache[region_name] = loc
              else
                loc = geo_cache[region_name]
              end
              if(loc.lng)
                locations << "#{loc.lng} #{loc.lat}"
              end
            end

            multi_point = "ST_MPointFromText('MULTIPOINT(#{locations.join(',')})',4326)" unless (locations.length<1)
          end

          p.save!

          #save the Geom that we created before
          if(!multi_point.blank?)
            sql="UPDATE projects SET the_geom=#{multi_point} WHERE id=#{p.id}"
            DB.execute sql
          end

        else
          puts "NOT FOUND #{row.organization}"
        end
      end

    end
  end
end