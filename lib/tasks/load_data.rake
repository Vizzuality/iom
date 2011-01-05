namespace :db do
  desc 'Remove,Create,Seed and load data'
  task :reset => %w(db:drop db:create db:migrate iom:data:load_countries db:seed iom:data:load_adm_levels iom:data:load_orgs iom:data:load_projects)

  desc 'reset 1'
  task :reset_1 => %w(db:drop db:create db:migrate iom:data:load_countries)

  desc 'reset 2'
  task :reset_2 => %w(db:seed iom:data:load_adm_levels iom:data:load_orgs iom:data:load_projects)

  desc 'reset 3'
  task :reset_3 => %w(db:seed iom:data:load_adm_levels iom:data:load_orgs iom:data:load_food_security)
end

namespace :iom do
  namespace :data do
    desc "Load organizations and projects data"
    task :all => %w(load_adm_levels load_orgs load_projects)

    desc "load country data"
    task :load_countries => :environment do
      DB = ActiveRecord::Base.connection
      system("unzip -o #{Rails.root}/db/data/countries/TM_WORLD_BORDERS-0.3.zip -d #{Rails.root}/db/data/countries/")
      system("shp2pgsql -d -s 4326 -gthe_geom -i -WLATIN1 #{Rails.root}/db/data/countries/TM_WORLD_BORDERS-0.3.shp public.tmp_countries | psql -Upostgres -diom_#{RAILS_ENV}")

      #Insert the country and get the value
      sql="INSERT INTO countries(\"name\",code,center_lat,center_lon,iso2_code,iso3_code)
      SELECT name,iso3,y(ST_Centroid(the_geom)),x(ST_Centroid(the_geom)),iso2,iso3 from tmp_countries
      where iso3 not in (select code from countries)"
      DB.execute sql

      #DB.execute "UPDATE countries SET center_lat=y(ST_Centroid(the_geom)),center_lon=x(ST_Centroid(the_geom))"
      #DB.execute "UPDATE countries SET the_geom_geojson=ST_AsGeoJSON(the_geom,6)"

      DB.execute 'DROP TABLE tmp_countries'
      system("rm -rf #{Rails.root}/db/data/countries/TM_WORLD_BORDERS-0.3.shp #{Rails.root}/db/data/countries/TM_WORLD_BORDERS-0.3.shx #{Rails.root}/db/data/countries/TM_WORLD_BORDERS-0.3.dbf #{Rails.root}/db/data/countries/TM_WORLD_BORDERS-0.3.prj #{Rails.root}/db/data/countries/Readme.txt")
    end

    desc "load all available regions not imported already"
    task :load_adm_levels => :environment do
      
      csv = CsvMapper.import("#{Rails.root}/db/data/gadm_data/gadm_level1.csv") do
        read_attributes_from_file
      end
      csv.each do |row|
        if (Region.find_by_gadm_id_and_level(row.gadm1_id,1).blank?)
          r = Region.new
          r.name = row.name
          r.level = 1
          r.country = Country.find_by_code(row.iso)
          r.center_lat = row.lat
          r.center_lon = row.lon
          r.gadm_id = row.gadm1_id
          r.ia_name = row.ia_name
          r.save!
          puts "created: 1 #{row.name}"  
        else
          puts "already existing: 1 #{row.name}"  
        end
      end
      
      csv = CsvMapper.import("#{Rails.root}/db/data/gadm_data/gadm_level2.csv") do
        read_attributes_from_file
      end
      csv.each do |row|
        if (Region.find_by_gadm_id_and_level(row.gadm2_id,2).blank?)
          r = Region.new
          r.name = row.name
          r.level = 2
          r.country = Country.find_by_code(row.iso)
          r.center_lat = row.lat
          r.center_lon = row.lon
          r.gadm_id = row.gadm2_id
          r.parent_region_id = Region.find_by_gadm_id_and_level(row.gadm1_id,1).id
          r.ia_name = row.ia_name
          r.save!
          puts "created: 2 #{row.name}"  
        else
          puts "already existing: 2 #{row.name}"  
        end
      end
      
      csv = CsvMapper.import("#{Rails.root}/db/data/gadm_data/gadm_level3.csv") do
        read_attributes_from_file
      end
      csv.each do |row|
        if (Region.find_by_gadm_id_and_level(row.gadm3_id,3).blank?)
          r = Region.new
          r.name = row.name
          r.level = 3
          r.country = Country.find_by_code(row.iso)
          r.center_lat = row.lat
          r.center_lon = row.lon
          r.gadm_id = row.gadm3_id
          r.ia_name = row.ia_name
          r.parent_region_id = Region.find_by_gadm_id_and_level(row.gadm2_id,2).id
          r.save!
          puts "created: 3 #{row.name}"  
        else
          puts "already existing: 3 #{row.name}"  
        end
      end
      
      #DB = ActiveRecord::Base.connection
      #Temporary matching for Google Map Charts
      # DB.execute "UPDATE regions set code='HT-GR' WHERE name like 'Grand%' and level=1"
      # DB.execute "UPDATE regions set code='HT-AR' WHERE name like '%Artibonite' and level=1"
      # DB.execute "UPDATE regions set code='HT-NI' WHERE name='Nippes' and level=1"
      # DB.execute "UPDATE regions set code='HT-ND' WHERE name='Nord' and level=1"
      # DB.execute "UPDATE regions set code='HT-NE' WHERE name='Nord-Est' and level=1"
      # DB.execute "UPDATE regions set code='HT-NO' WHERE name='Nord-Ouest' and level=1"
      # DB.execute "UPDATE regions set code='HT-OU' WHERE name='Ouest' and level=1"
      # DB.execute "UPDATE regions set code='HT-SD' WHERE name='Sud' and level=1"
      # DB.execute "UPDATE regions set code='HT-SE' WHERE name='Sud-Est' and level=1"
      # DB.execute "UPDATE regions set code='HT-CE' WHERE name='Centre' and level=1"
    end

    desc 'Load organizations data'
    task :load_orgs => :environment do

      csv_orgs = CsvMapper.import("#{Rails.root}/db/data/haiti_organizations.csv") do
        read_attributes_from_file
      end
      csv_orgs.each do |row|
        if(Organization.find_by_name(row.organization).blank?)
          o = Organization.new
          o.name                    = row.organization
          o.website                 = row.website
          o.description             = row.about
          o.international_staff     = row.international_staff
          o.contact_name            = row.us_contact_name
          o.contact_position        = row.us_contact_title
          o.contact_phone_number    = row.us_contact_phone
          o.contact_email           = row.us_contact_email
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


          # Site specific attributes for Haiti
          o.attributes_for_site = {:organization_values => {:description=>row.organizations_work_in_haiti}, :site_id => 1}
          o.save!
          puts "Created ORG: #{o.name}"
        else
          puts "ORG already imported"
        end
      end
    end

    desc 'Load projects data'
    task :load_projects  => :environment do

      DB = ActiveRecord::Base.connection
      # Cache geocoding
      geo_cache = {}

      csv_projs = CsvMapper.import("#{Rails.root}/db/data/projects_latest.csv") do
        read_attributes_from_file
      end
      csv_projs.each do |row|
        # Organization names mapping 
        if row.organization.strip == "U.S. Committee for Refugees & Immigrants (USCRI)"
          row.organization = "US Committee for Refugees & Immigrants (USCRI)"
        end
        o = Organization.find_by_name(row.organization.strip)
        unless o
          puts "ORG NOT FOUND: \"#{row.organization}\""
          next
        end
        unless Project.find_by_intervention_id(row.ipc)
          p = Project.new
          #puts "#{row.ipc} : #{row.project_title}"
          p.primary_organization      = o
          p.intervention_id           = row.ipc
          p.name                      = (row.project_title.blank? ? "Unknown" : row.project_title)
          p.description               = row.project_description
          p.activities                = row.project_activities
          p.additional_information    = row.additional_information
          p.awardee_type              = row.awardee_type
          p.verbatim_location         = row.cityvillage
          p.calculation_of_number_of_people_reached = row.calculation_of_number_of_people_reached
          p.project_needs             = row.project_needs
          p.idprefugee_camp           = row.idprefugee_camp

          unless row.est_start_date.blank?
            begin
              if(row.est_end_date=="2/29/2010")
                row.est_end_date="3/1/2010"
              end
              p.start_date = Date.strptime(row.est_start_date, '%m/%d/%Y')
            rescue
              p.start_date = Date.parse(row.est_start_date)
            end
          end
          
          unless row.est_end_date.blank? or row.est_end_date=="Ongoing"
            begin
              p.end_date = Date.strptime(row.est_end_date, '%m/%d/%Y')
            else
              p.end_date = Date.parse(row.est_end_date)
            end
          end
          
          if p.end_date && p.start_date && p.end_date < p.start_date
            puts p.name
            puts row.est_start_date
            puts row.est_end_date
            next
          end

          p.budget                    = row.budget.to_money.dollars unless (row.budget.blank?)
          p.cross_cutting_issues      = row.crosscutting_issues
          p.implementing_organization = row.implementing_organizations
          p.partner_organizations     = row.partner_organizations
          p.estimated_people_reached  = row.number_of_people_reached_target
          p.target                    = row.target_groups
          p.contact_person            = row.contact_name
          p.contact_position          = row.contact_title
          p.contact_email             = row.contact_email
          p.website                   = row.website
          unless row.date_provided.blank?
            begin
              p.date_provided = Date.strptime(row.date_provided, '%m/%d/%Y') 
            rescue
              p.date_provided = Date.parse(row.date_provided)
            end
          end
          unless row.date_updated.blank?
            begin
              p.date_updated = Date.strptime(row.date_updated, '%m/%d/%Y')
            rescue
              p.date_updated = Date.parse(row.date_updated)
            end
          end

          # Relations
          #########################

          # -->Clusters
          if(!row.clusters.blank?)
            parsed_clusters = row.clusters.split(",").map{|e|e.strip}
            parsed_clusters.each do |clus|
              p.clusters << Cluster.find_or_create_by_name(:name=>clus.strip)
            end
          end

          # -->Sectors
          # they come separated by commas
          if(!row.ia_sectors.blank?)
            parsed_sectors = row.ia_sectors.split(",").map{|e|e.strip}
            parsed_sectors.each do |sec|
              p.sectors << Sector.find_or_create_by_name(:name=>sec.strip)
            end
          end

          # -->Donor
          if(!row.donors.blank?)
            parsed_donors = row.donors.split(",").map{|e|e.strip}
            parsed_donors.each do |don|

              donor= Donor.where("name ilike ?",don).first
              if(!donor)
                donor = Donor.new
                donor.name =don
                donor.save!
              end
              donation = Donation.new
              donation.project = p
              donation.donor = donor
              p.donations << donation
            end
          end

          p.save!

          # -->Country
          if (!row.country.blank?)
            country = Country.where("name ilike ?",row.country.strip).select(Country.custom_fields).first
            if(country)
              p.countries  << country
            else
              puts "ALERT: COUNTRY NOT FOUND #{row.country}"
            end
          end

          multi_point=""
          reg3=nil
          if(!row._3rd_administrative_level.blank?)
            parsed_adm3 = row._3rd_administrative_level.split(",").map{|e|e.strip}
            locations = Array.new
            if(!row.latitude.blank? and !row.longitude.blank?)
              coords_lat_split=row.latitude.split(",").map{|e|e.strip}
              coords_lon_split=row.longitude.split(",").map{|e|e.strip}
              count = 0
              coords_lat_split.each do |lat_split|
                if(lat_split.to_f!=0 and coords_lon_split[count].to_f!=0)
                  locations << "#{lat_split} #{coords_lon_split[count]}"
                end
                count = count+1
              end
            end
            parsed_adm3.each do |region_name|
              reg3 = Region.where("ia_name ilike ? and level=? and country_id=?",region_name.strip,3,country.id).select(Region.custom_fields).first
              if(reg3)
                p.regions  << reg3
                if(locations.count<1)
                  sql="select ST_AsText(ST_SetSRID(ST_MakePoint(center_lon,center_lat),4326)) as point from regions where id=#{reg3.id}"
                  res = DB.execute(sql).first["point"].delete("POINT(").delete(")")
                  locations << res
                end
                
                #Add the herarchy
                region_level2= Region.find_by_id(reg3.parent_region_id)
                p.regions  << region_level2
                
                region_level1= Region.find_by_id(region_level2.parent_region_id)
                p.regions  << region_level1                
              else
                puts "ALERT: REGION LEVEL 3 NOT FOUND #{region_name}"
              end
            end

            multi_point = "ST_MPointFromText('MULTIPOINT(#{locations.join(',')})',4326)" unless (locations.length<1)
          end

          #save the Geom that we created before
          if(!multi_point.blank?)
            sql="UPDATE projects SET the_geom=#{multi_point} WHERE id=#{p.id}"
            DB.execute sql
          end

        else
          puts "Project \"#{row.project_title}\" ALREADY IMPORTED"
        end

        Site.all.each{ |site| site.save! }

      end

    end

    desc 'Load data for Food Security'
    task :load_food_security => :environment do
      DB = ActiveRecord::Base.connection

      csv_projs = CsvMapper.import("#{Rails.root}/db/data/fs_data_round1_consolidated.csv") do
        read_attributes_from_file
      end

      # Cache geocoding
      geo_cache = {}

      csv_projs.each do |row|
        p = Project.new
        # Map organization names with existing names
        organization = case row.organization.strip
          when 'Adventist Development and Relief Agency International'
            'Adventist Development and Relief Agency'
          when 'Catholic Relief Services'
            'Catholic Relief Services (CRS)'
          when 'Heifer International'
            'Heifer International'
          when 'Helen Keller International'
            row.organization
          when 'Oxfam America'
            row.organization
          when 'PATH'
            row.organization
          when 'Planet Aid'
            row.organization
          when 'Save the Children'
            'Save the Children'
          when 'The Hunger Project'
            row.organization
          when 'Women for Women International'
            row.organization
          when 'World Vision United States'
            'World Vision US, Inc.'
          else
            row.organization
        end
        o = Organization.find_by_name(organization)
        if o
          puts "PROJECT FOR: #{o.id}"
          p.primary_organization      = o
          p.intervention_id           = row.ipc
          p.name                      = row.interv_title
          p.description               = row.interv_description
          p.activities                = row.interv_activities
          p.additional_information    = row.additional_information

          unless row.start_date_mmddyyyy.blank?
            start_date = row.start_date_mmddyyyy.strip
            if start_date =~ /^(\d{2})\/(\d{2})\/(\d{2})$/
              start_date = if $3.to_i > 10
                "#{$1}/#{$2}/19#{$3}"
              else
                "#{$1}/#{$2}/20#{$3}"
              end
            end
            p.start_date = Date.strptime(start_date, '%m/%d/%Y')
          end

          if row.end_date_mmddyyyy=="2/29/2010"
            row.end_date_mmddyyyy="3/1/2010"
          end

          if row.end_date_mmddyyyy == '1/1/'
            row.end_date_mmddyyyy = nil
          end

          unless (row.end_date_mmddyyyy.blank? or row.end_date_mmddyyyy=="Ongoing")
            end_date = row.end_date_mmddyyyy.strip
            if end_date =~ /^(\d{2})\/(\d{2})\/(\d{2})$/
              end_date = "#{$1}/#{$2}/20#{$3}"
            end
            p.end_date = Date.strptime(end_date, '%m/%d/%Y')
          end

          p.cross_cutting_issues      = row.crosscutting_issues
          p.implementing_organization = row.implementing_organizations
          p.partner_organizations     = row.partner_organizations
          p.awardee_type              = row.awardee_type_prime_awardeesubawardee
          p.estimated_people_reached  = row.number_of_people_reached_target
          p.target                    = row.target_groups
          p.contact_person            = row.contact_name
          p.contact_position          = row.contact_title
          p.contact_email             = row.contact_email
          p.website                   = row.website
          p.date_provided             = Date.strptime(row.date_provided_mmddyyyy, '%m/%d/%Y') unless (row.date_provided_mmddyyyy.blank?)
          p.date_updated              = Date.strptime(row.date_updated_mmddyyyy, '%m/%d/%Y') unless (row.date_updated_mmddyyyy.blank?)

          # Relations
          #########################

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

              donor= Donor.where("name ilike ?",don).first
              if(!donor)
                donor = Donor.new
                donor.name =don
                donor.save!
              end
              donation = Donation.new
              donation.project = p
              donation.donor = donor
              p.donations << donation
            end
          end

          p.save!

          # -->Country
          unless row.country.blank?
            row.country.split(',').map{ |c| c.strip }.each do |country_name|
              country = Country.where("name ilike ?",country_name).select(Country.custom_fields).first
              if(country)
                p.countries  << country
              else
                puts "ALERT: COUNTRY NOT FOUND #{country_name}"
              end
            end
          end

          #Geo data
          reg1=nil
          if(!row._1st_administrative_level.blank?)
            parsed_adm1 = row._1st_administrative_level.split(",").map{|e|e.strip}
            parsed_adm1.each do |region_name|
              reg1 = Region.where("name ilike ? and level=?",region_name,1).select(Region.custom_fields).first
              if(reg1)
                p.regions  << reg1
              else
                puts "ALERT: REGION LEVEL 1 NOT FOUND #{region_name}"
              end
            end
          end
          if p.regions.empty?
            puts "[error] empty regions"
            next
          end

          reg2=nil
          if(!row._2nd_administrative_level.blank?)
            parsed_adm2 = row._2nd_administrative_level.split(",").map{|e|e.strip}
            parsed_adm2.each do |region_name|
              reg2 = Region.where("name ilike ? and level=?",region_name,2).select(Region.custom_fields).first
              if(reg2)
                p.regions  << reg2
              else
                puts "ALERT: REGION LEVEL 2 NOT FOUND #{region_name}"
              end

            end
          end

          multi_point=""
          reg3=nil
          if(!row._3rd_administrative_level.blank?)
            parsed_adm3 = row._3rd_administrative_level.split(",").map{|e|e.strip}
            locations = Array.new
            parsed_adm3.each do |region_name|
              reg3 = Region.where("name ilike ? and level=?",region_name,3).select(Region.custom_fields).first
              if(reg3)
                p.regions  << reg3
                sql="select ST_AsText(ST_PointOnSurface(the_geom)) as point from regions where id=#{reg3.id}"
                res = DB.execute(sql).first["point"].delete("POINT(").delete(")")
                locations << res
              else
                puts "ALERT: REGION LEVEL 3 NOT FOUND #{region_name}"
              end
            end

            multi_point = "ST_MPointFromText('MULTIPOINT(#{locations.join(',')})',4326)" unless (locations.length<1)
          end

          #save the Geom that we created before
          if(!multi_point.blank?)
            sql="UPDATE projects SET the_geom=#{multi_point} WHERE id=#{p.id}"
            DB.execute sql
          end

        else
          puts "NOT FOUND #{row.organization}"
        end
      end

      puts
      puts "Importing finished"

      Site.all.each{ |site| site.save! }
    end

  end
end
