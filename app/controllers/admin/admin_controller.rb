class Admin::AdminController < ApplicationController
  before_filter :login_required

  def index
  end

  def export_projects
    options = {}
    options[:organization] = params[:organization_id] if params[:organization_id].present?
    results_in_csv = Project.to_csv(nil, options)
    results_in_excel = Project.to_excel(nil, options)

    respond_to do |format|
      format.html do
        render :text => results_in_csv
      end
      format.csv do
        send_data results_in_csv,
          :type => 'text/plain; charset=utf-8; application/download',
          :disposition => "attachment; filename=ngoaidmap_projects.csv"
      end
      format.xls do
        send_data results_in_excel,
          :type => 'application/vnd.ms-excel',
          :disposition => "attachment; filename=ngoaidmap_projects.xls"
      end
    end
  end

  def export_organizations
    sql = <<-SQL
  select * from organizations
SQL
    results = ActiveRecord::Base.connection.execute(sql)

    results_in_csv = FasterCSV.generate(:col_sep => ';') do |csv|
      csv << results.first.keys
      results.each do |result|
        line = []
        result.each do |k,v|
          line << if v.nil?
            ""
          else
            if %W{ start_date end_date date_provided date_updated }.include?(k)
              if v =~ /^00(\d\d\-.+)/
                "20#{$1}"
              else
                v
              end
            else
              v.text2array.join(',')
            end
          end
        end
        csv << line
      end
    end

    respond_to do |format|
      format.html do
        render :text => results_in_csv
      end
      format.csv do
        send_data results_in_csv,
          :type => 'text/plain; charset=utf-8; application/download',
          :disposition => "attachment; filename=ngoaidmap_organizations.csv"
      end
    end
  end
end