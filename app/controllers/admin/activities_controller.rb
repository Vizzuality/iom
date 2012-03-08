class Admin::ActivitiesController < Admin::AdminController
  before_filter :get_search_params, :only => :show
  before_filter :get_changes, :only => :show
  before_filter :paginate, :only => :show

  def show
  end

  def get_search_params
    search_params = {
      'who'        => nil,
      'what_type'  => nil,
      'when_start' => nil,
      'when_end'   => nil
    }.
    merge(process_dates(params[:search]) || {})

    @search = OpenStruct.new(search_params)
  end
  private :get_search_params

  def get_changes
    @changes = ChangesHistoryRecord.search(@search)

    @project      = Project.find(params[:project_id])           if params[:project_id].present?
    @organization = Organization.find(params[:organization_id]) if params[:organization_id].present?

    @changes = @project.changes_history_records      if @project
    @changes = @organization.changes_history_records if @organization
  end
  private :get_changes

  def paginate
    @changes = @changes.paginate :per_page => 20, :order => 'changes_history_records.when DESC', :page => params[:page]
  end
  private :paginate

  def process_dates(hash)
    return if hash.blank?
    %w(when_start when_end).each do |attribute|
      hash[attribute] = Date.new(hash[attribute + '(1i)'].to_i, hash[attribute + '(2i)'].to_i, hash[attribute + '(3i)'].to_i) rescue nil
    end
    hash
  end
  private :process_dates

end
