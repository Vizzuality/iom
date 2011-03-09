class Admin::AdminController < ApplicationController
  before_filter :login_required

  def index
  end

  def export_projects
    sql = "select * from projects limit 10"
    results = ActiveRecord::Base.connection.execute(sql)

    # FasterCSV.generate(:col_sep => ';') do |csv|
    #   csv << self.class.csv_attributes
    #   csv << csv_columns(site_id)
    # end

    respond_to do |format|
      format.html do
        render :text => results.to_json
      end
      format.csv do
        send_data results_in_csv,
          :type => 'application/download; application/vnd.ms-excel; text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=ngoaidmap_projects.csv"
      end
    end
  end

end