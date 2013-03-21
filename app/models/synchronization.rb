class Synchronization
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :projects_file, :projects_errors

  validates_presence_of :projects_file
  validate :projects_file_data

  def persisted?
    false
  end

  def valid?
    super && projects_errors.blank?
  end

  def initialize(file = nil)
    return if file.blank?

    self.projects_file = file

    setup_book(projects_file.tempfile)
  end

  #def projects_file=(file)
    #return if file.blank?

    #CsvMapper.import(file, :type => :io) do
      #map_to Project
      #after_row lambda{ |row, project|
        #csv_projects << project
      #}

      #start_at_row 1
      #read_attributes_from_file
    #end

    #Project.delete(projects_ids_to_delete - csv_projects.map{|p| p.id})
  #end

  def setup_book(file)
    @book   = Spreadsheet.open file
    @sheet  = @book.worksheet(0)
    @header = @sheet.row(0)
    @line   = 0
  end

  def projects_errors
    @projects_errors ||= []
  end

  def projects_errors_count
    projects_errors.size
  end

  def as_json(options = {})
    {
      :success => self.valid?,
      :title => "There are #{projects_errors_count} problems with the selected file",
      :errors => projects_errors
    }
  end

  private

  def projects_file_data
    @sheet.each do |file_raw_row|
      @line += 1
      next if file_raw_row == @header

      row_hash   = convert_excel_row_to_hash(file_raw_row)

      project             = instantiate_project(row_hash)
      project.attributes  = row_hash.slice(*Project.columns_hash.keys)
      project.name        = row_hash['project_name']
      project.description = row_hash['project_description']

      process_project_associations(row_hash, project)

      process_project_validations(row_hash, project)
    end
  end

  def projects_ids_to_delete
    @projects_ids_to_delete ||= []
  end

  def csv_projects
    @csv_projects ||= []
  end

  def convert_excel_row_to_hash(sheet)
    Hash[*(@header.to_a).zip(sheet.to_a).flatten]
  end

  def instantiate_project(project_hash)
    if project_hash['interaction_intervention_id'].present?
      Project.where(:intervention_id => project_hash.delete('interaction_intervention_id')).first
    else
      Project.new
    end
  end

  def process_project_associations(row_hash, project)
      process_organization(row_hash, project)

      process_countries(row_hash, project)

      process_first_admin_level(row_hash, project)

      process_second_admin_level(row_hash, project)

      process_third_admin_level(row_hash, project)

      process_sectors(row_hash, project)

      process_clusters(row_hash, project)

      process_donors(row_hash, project)
  end

  def process_organization(row_hash, project)
    if row_hash['organization'] && (organization = Organization.find_by_name(row_hash['organization'])) && organization.present?
      project.primary_organization = organization
    end
  end

  def process_countries(row_hash, project)
    if row_hash['countries'] && (countries = row_hash['countries'].text2array) && countries.present?
      project.countries.clear
      countries.each do |country_name|
        country = Country.where(:name => country_name).first
        if country.blank?
          self.projects_errors << "Country #{country_name} doesn't exist on line #@line"
          next
        end
        project.countries << country
      end
    end
  end

  def process_first_admin_level(row_hash, project)
    if row_hash['first_admin_level'] && (first_admin_levels = row_hash['first_admin_level'].text2array) && first_admin_levels.present?
      project.regions.where(:level => 1).clear
      first_admin_levels.each do |first_admin_level_name|
        region = Region.where(:name => first_admin_level_name).first
        if region.blank?
          self.projects_errors << "1st Admin level #{first_admin_level_name} doesn't exist on line #@line"
          next
        end
        project.regions << region
      end
    end
  end

  def process_second_admin_level(row_hash, project)
    if row_hash['second_admin_level'] && (second_admin_levels = row_hash['second_admin_level'].text2array) && second_admin_levels.present?
      project.regions.where(:level => 2).clear
      second_admin_levels.each do |second_admin_level_name|
        region = Region.where(:name => second_admin_level_name).first
        if region.blank?
          self.projects_errors << "2nd Admin level #{second_admin_level_name} doesn't exist on line #@line"
          next
        end
        project.regions << region
      end
    end
  end

  def process_third_admin_level(row_hash, project)
    if row_hash['third_admin_level'] && (third_admin_levels = row_hash['third_admin_level'].text2array) && third_admin_levels.present?
      project.regions.where(:level => 3).clear
      third_admin_levels.each do |third_admin_level_name|
        region = Region.where(:name => third_admin_level_name).first
        if region.blank?
          self.projects_errors << "3rd Admin level #{third_admin_level_name} doesn't exist on line #@line"
          next
        end
        project.regions << region
      end
    end
  end

  def process_sectors(row_hash, project)
    if row_hash['sectors'] && (sectors = row_hash['sectors'].text2array) && sectors.present?
      project.sectors.clear
      sectors.each do |sector_name|
        sector = Sector.where(:name => sector_name).first
        if sector.blank?
          self.projects_errors << "Sector #{sector_name} doesn't exist on line #@line"
          next
        end
        project.sectors << sector
      end
    end
  end

  def process_clusters(row_hash, project)
    if row_hash['clusters'] && (clusters = row_hash['clusters'].text2array) && clusters.present?
      project.clusters.clear
      clusters.each do |cluster_name|
        cluster = Cluster.where(:name => cluster_name).first
        if cluster.blank?
          self.projects_errors << "cluster #{cluster_name} doesn't exist on line #@line"
          next
        end
        project.clusters << cluster
      end
    end
  end

  def process_donors(row_hash, project)
    if row_hash['donors'] && (donors = row_hash['donors'].text2array) && donors.present?
      project.donors.clear
      donors.each do |donor_name|
        donor = Donor.where(:name => donor_name).first
        if donor.blank?
          self.projects_errors << "donor #{donor_name} doesn't exist on line #@line"
          next
        end
        project.donors << donor
      end
    end
  end

  def process_project_validations(row_hash, project)
    self.projects_errors += project.errors.to_a.map{|msg| "#{msg} on line #@line"} unless project.valid?
  end

end
