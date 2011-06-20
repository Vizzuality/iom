class Admin::AdminController < ApplicationController
  before_filter :login_required

  def index
  end

  def export_projects
    where = []
    if params[:organization_id].present?
      where << "organization_id = #{params[:organization_id].sanitize_sql!}"
    end
    where = "WHERE #{where.join('AND')}" if where.present?

    sql = <<-SQL
    select distinct
    site_id,
    project_id,
    project_name,
    project_description,
    organization_id,
    organization_name as organization,
    implementing_organization,
    partner_organizations,
    cross_cutting_issues,
    p.start_date,
    p.end_date,
    CASE WHEN budget=0 THEN null ELSE budget END as budget_numeric,
    target,
    estimated_people_reached,
    contact_person as project_contact_person,
    contact_email as project_contact_email,
    contact_phone_number as project_contact_phone_number,
    activities,
    intervention_id,
    additional_information,
    awardee_type,
    date_provided,
    date_updated,
    contact_position as project_contact_position,
    website as project_website,
    verbatim_location,
    calculation_of_number_of_people_reached,
    project_needs,
    sectors,
    clusters,
    (select '|' || array_to_string(array_agg(distinct name),'|') ||'|' from tags as t inner join projects_tags as pt on t.id=pt.tag_id where pt.project_id=dd.project_id) as project_tags,
    countries,
    (select '|' || array_to_string(array_agg(distinct name),'|') ||'|' from regions as r inner join projects_regions as pr on r.id=pr.region_id where r.level=1 and pr.project_id=dd.project_id) as regions_level1,
    (select '|' || array_to_string(array_agg(distinct name),'|') ||'|' from regions as r inner join projects_regions as pr on r.id=pr.region_id where r.level=2 and pr.project_id=dd.project_id) as regions_level2,
    (select '|' || array_to_string(array_agg(distinct name),'|') ||'|' from regions as r inner join projects_regions as pr on r.id=pr.region_id where r.level=3 and pr.project_id=dd.project_id) as regions_level3,
    (select '|' || array_to_string(array_agg(distinct name),'|') ||'|' from donors as d inner join donations as dn on d.id=dn.donor_id and dn.project_id=dd.project_id) as donors
    from data_denormalization as dd inner join projects as p on dd.project_id=p.id
    #{where}
    group by
    site_id,
    project_id,
    project_name,
    project_description,
    organization_id,
    organization_name,
    implementing_organization,
    partner_organizations,
    cross_cutting_issues,
    p.start_date,
    p.end_date,
    budget,
    target,
    estimated_people_reached,
    contact_person,
    contact_email,
    contact_phone_number,
    activities,
    intervention_id,
    additional_information,
    awardee_type,
    date_provided,
    date_updated,
    contact_position,
    website,
    verbatim_location,
    calculation_of_number_of_people_reached,
    project_needs,
    idprefugee_camp,
    countries,
    sectors,
    clusters
SQL
    results = ActiveRecord::Base.connection.execute(sql)

    ordered_header = %w(organization intervention_id project_name project_description activities additional_information start_date end_date budget_numeric clusters sectors cross_cutting_issues implementing_organization partner_organizations donors awardee_type estimated_people_reached calculation_of_number_of_people_reached target countries regions_level1 regions_level2 regions_level3 verbatim_location,
idprefugee_camp project_contact_person project_contact_position project_contact_email project_contact_phone_number project_website date_provided date_updated project_needs)

    results_in_csv = FasterCSV.generate(:col_sep => ';') do |csv|
      csv << ordered_header
      results.each do |result|
        line = []
        ordered_header.each do |field_name|
          v = result[field_name]
          line << if v.nil?
            ""
          else
            if %W{ start_date end_date date_provided date_updated }.include?(field_name)
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
          :disposition => "attachment; filename=ngoaidmap_projects.csv"
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