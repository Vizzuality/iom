class ProjectsSynchronization < ActiveRecord::Base

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
      row_hash.each{|k, v| project.send("#{k}=", v) }
      self.projects_errors += project.sync_errors
      project.updated_by  = user

      process_project_validations(row_hash, project)

    end
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
    header = sheet.row(0).to_a

    self.projects_file_data = []
    sheet.each_with_index do |sheet_row, i|
      next if i == 0
      row_hash = {}
      sheet_row.each_with_index do |c, j|
        row_hash[header[j]] = sheet_row[j]
      end
      self.projects_file_data << row_hash
    end
  end

  def instantiate_project(project_hash)
    if project_hash['interaction_intervention_id'].present?
      Project.where(:intervention_id => project_hash['interaction_intervention_id']).first || Project.new
    else
      Project.new
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
