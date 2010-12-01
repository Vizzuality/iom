namespace :iom do
  namespace :data do
    desc 'Load data'
    task :load_orgs => :environment do
      DB = ActiveRecord::Base.connection
      
      #The haitiAidMap must be already created and it has ID=1
      
      csv_orgs = CsvMapper.import("#{Rails.root}/db/data/organizations_20_10_10.csv") do
        read_attributes_from_file
      end
      csv_orgs.each do |row|
        o = Organization.new
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
        
        #Site specific attributes for Haiti
        o.attributes_for_site = {:organization_values => {:description=>row.organizations_work_in_haiti}, :site_id => 1}
        o.save!
        puts row.organization
      end
      
      
      # csv_projs = CsvMapper.import("#{Rails.root}/db/data/projects_20_10_10.csv") do
      #   read_attributes_from_file
      # end      
    
    end
    task :load_projects => :environment do
      DB = ActiveRecord::Base.connection
      
      #The haitiAidMap must be already created and it has ID=1      
      
      csv_projs = CsvMapper.import("#{Rails.root}/db/data/projects_20_10_10.csv") do
        read_attributes_from_file
      end
      csv_projs.each do |row|
        p = Project.new
        o = Organization.find_by_name(row.organization)
        if o
          puts o.id
          p.primary_organization = o
          p.name = row.interv_title
          p.description = row.interv_description
          #puts "#{row.est_start_date_mmddyyyy} - #{row.est_end_date_mmddyyyy}"
          p.start_date = Date.strptime(row.est_start_date_mmddyyyy, '%m/%d/%Y') unless (row.est_start_date_mmddyyyy.blank?)
          if(row.est_end_date_mmddyyyy=="2/29/2010")
            row.est_end_date_mmddyyyy="3/1/2010"
          end
          p.end_date = Date.strptime(row.est_end_date_mmddyyyy, '%m/%d/%Y') unless (row.est_end_date_mmddyyyy.blank? or row.est_end_date_mmddyyyy=="Ongoing")
          p.save!
          
        else
          puts "NOT FOUND #{row.organization}"
        end
      end
    
    end    
  end
end