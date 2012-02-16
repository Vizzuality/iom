class Admin::ActivitiesController < Admin::AdminController
  before_filter :get_search_params, :only => :show
  before_filter :get_changes, :only => :show
  before_filter :paginate, :only => :show

  def show
  end

  def get_search_params
    search_params = {
      :who        => nil,
      :what_type  => nil,
      :when_start => nil,
      :when_end   => nil
    }.
    merge(params[:search] || {})

    @search = OpenStruct.new(search_params)
  end
  private :get_search_params

  def get_changes
    @project = Project.find(params[:project_id]) if params[:project_id].present?
    @changes = ChangesHistoryRecord
    @changes = @project.changes_history_records if @project
  end
  private :get_changes

  def paginate
    @changes = @changes.paginate :per_page => 20, :order => 'changes_history_records.when DESC', :page => params[:page]
  end
  private :paginate

end
