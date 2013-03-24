class ProjectsSynchronization < ActiveRecord::Base

  attr_accessor :projects_file, :projects_errors

  serialize :projects_file_data, Array

  validates_presence_of :projects_file, :on => :create

  before_save :process_projects_file_data
  before_create :save_projects_if_no_errors
  before_update :save_projects_anyway

  def valid?(context = nil)
    super && projects_errors.blank?
  end

  def setup_book
    book    = Spreadsheet.open projects_file.tempfile

    convert_file_to_hash_array(book.worksheet(0))
  end

  def projects_errors
    @projects_errors ||= []
  end

  def projects_errors_count
    projects_errors.size
  end

  def projects_updated_count
    @projects.count
  end

  def as_json(options = {})
    {
      :id                     => id,
      :success                => self.valid?,
      :title                  => "There are #{projects_errors_count} problems with the selected file",
      :errors                 => projects_errors,
      :projects_updated_count => projects.count
    }
  end

  private

  def projects
    @projects ||= []
  end

  def process_projects_file_data
    setup_book unless persisted?

    @line   = 0
    projects_file_data.each do |row_hash|
      @line += 1
      next if row_hash.values - row_hash.keys == []

      project             = instantiate_project(row_hash)
      project.attributes  = row_hash.slice(*Project.columns_hash.keys)
      project.name        = row_hash['project_name']
      project.description = row_hash['project_description']

      process_project_associations(row_hash, project)

      process_project_validations(row_hash, project)

    end
  end

  def save_projects_if_no_errors
    if projects_errors.blank?
      projects.each(&:save)
      false
    end
  end

  def save_projects_anyway
    projects.each(&:save)
    self.destroy
  end

  def projects_ids_to_delete
    @projects_ids_to_delete ||= []
  end

  def csv_projects
    @csv_projects ||= []
  end

  def convert_file_to_hash_array(sheet)
    header = sheet.row(0).to_a

    self.projects_file_data = []
    sheet.each do |sheet_row|
      self.projects_file_data << Hash[*(header).zip(sheet_row.to_a).flatten]
    end
  end

  def instantiate_project(project_hash)
    if project_hash['interaction_intervention_id'].present?
      Project.where(:intervention_id => project_hash['interaction_intervention_id']).first
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
        project.countries.reload
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
        project.regions.reload
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
        project.regions.reload
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
        project.regions.reload
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
        project.sectors.reload
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
        project.clusters.reload
      end
    end
  end

  def process_donors(row_hash, project)
    if row_hash['donors'] && (donors = row_hash['donors'].text2array) && donors.present?
      project.donors.clear
      donors.each do |donor_name|
        donor = Donor.find_by_name(donor_name)
        if donor.blank?
          self.projects_errors << "donor #{donor_name} doesn't exist on line #@line"
          next
        end
        project.donors << donor
        project.donors.reload
      end
    end
  end

  def process_project_validations(row_hash, project)
    if project.valid?
      projects << project
    else
      self.projects_errors += project.errors.to_a.map{|msg| "#{msg} on line #@line"}
    end
  end

end
