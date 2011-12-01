class Admin::AdminController < ApplicationController
  before_filter :login_required
  before_filter :check_user_permissions

  def index
  end

  def export_projects
    options = {
      :include_non_active =>true
    }
    options[:organization] = params[:organization_id] if params[:organization_id].present?
    options[:organization] = current_user.organization_id unless current_user.admin?
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

  def check_user_permissions
    unless current_user.admin?
      redirect_to admin_projects_path unless controller_name == 'projects' || controller_name == 'organizations' || (controller_name == 'admin' && action_name == 'export_projects')
    end
  end
  private :check_user_permissions
end
