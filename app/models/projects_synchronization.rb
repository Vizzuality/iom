class ProjectsSynchronization < ActiveRecord::Base

  REQUIRED_HEADERS = %w(organization project_name project_description start_date end_date sectors location)

  attr_accessor :projects_file, :projects_errors, :user

  serialize :projects_file_data, Array

  validates_presence_of :projects_file, :on => :create

  before_save :process_projects_file_data
  before_create :save_projects_if_no_errors
  before_update :save_projects_anyway

  def valid?(context = nil)
    super && projects_errors.blank?
  end

  def setup_book
    book = Spreadsheet.open projects_file.tempfile
    book.add_format Spreadsheet::Format.new(:number_format => 'MM/DD/YYYY')

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
      :id                         => id,
      :success                    => self.valid?,
      :title                      => "There are #{projects_errors_count} problems with the selected file",
      :errors                     => projects_errors,
      :projects_updated_count     => projects.count,
      :projects_not_updated_count => project_not_updated.count
    }
  end

  private

  def projects
    @projects ||= []
  end

  def project_not_updated
    @project_not_updated ||= []
  end

  def process_projects_file_data
    setup_book unless persisted?

    @line   = 1
    projects_file_data.each do |row_hash|
      @line += 1
      next if row_hash.values - row_hash.keys == []

      project           = instantiate_project(row_hash)
      project.sync_mode = true
      project.sync_line = @line
      row_hash.each{|k, v| puts "#{k}_sync=";project.send("#{k.downcase.strip}_sync=", v) rescue nil }
      self.projects_errors += project.sync_errors
      project.updated_by  = user

      process_project_validations(row_hash, project)

    end
  rescue Ole::Storage::FormatError
    self.projects_errors << 'Invalid File. File must be an Excel 97-2003 file'
  rescue Exception => e
    logger.error e
    logger.error e.backtrace.join("\n")
    self.projects_errors << 'Unexpected error. Please, try again later.'
  end

  def save_projects_if_no_errors
    if projects_errors.blank?
      projects.each(&:save)
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
    header = sheet.row(0).to_a.map(&:downcase).map(&:strip)

    self.projects_file_data = []
    sheet.each_with_index do |sheet_row, i|
      next if i == 0
      row_hash = Hash[header.map{|h| [h, nil]}]
      sheet_row.each_with_index do |c, j|
        row_hash[header[j]] = sheet_row[j]
      end
      self.projects_file_data << row_hash
    end
  end

  def instantiate_project(project_hash)
    if project_hash['interaction_intervention_id'].present?
      Project.where('lower(trim(intervention_id)) = lower(trim(?))', project_hash['interaction_intervention_id'].try(:to_s)).first || Project.new
    else
      Project.new
    end
  end

  def process_project_validations(row_hash, project)
    if project.invalid?
      self.projects_errors += project.errors.full_messages.flatten.map{|msg| "#{msg} on row #@line"}
      project_not_updated << project
    else
      projects << project
    end

    if row_hash['interaction_intervention_id'].present?
      #self.projects_errors << "Missing interaction_intervention_id on line #@line" if  row_hash.keys - ['interaction_intervention_id'] == []
    else
      missing_fields = REQUIRED_HEADERS - row_hash.keys.map(&:downcase)
      self.projects_errors << %Q{Missing required fields "#{missing_fields.join(', ')}" on line #@line} if missing_fields != []
    end
  end

end
