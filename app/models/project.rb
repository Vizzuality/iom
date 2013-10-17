# == Schema Information
#
# Table name: projects
#
#  id                                      :integer         not null, primary key
#  name                                    :string(2000)
#  description                             :text
#  primary_organization_id                 :integer
#  implementing_organization               :text
#  partner_organizations                   :text
#  cross_cutting_issues                    :text
#  start_date                              :date
#  end_date                                :date
#  budget                                  :float
#  target                                  :text
#  estimated_people_reached                :integer(8)
#  contact_person                          :string(255)
#  contact_email                           :string(255)
#  contact_phone_number                    :string(255)
#  site_specific_information               :text
#  created_at                              :datetime
#  updated_at                              :datetime
#  the_geom                                :string
#  activities                              :text
#  intervention_id                         :string(255)
#  additional_information                  :text
#  awardee_type                            :string(255)
#  date_provided                           :date
#  date_updated                            :date
#  contact_position                        :string(255)
#  website                                 :string(255)
#  verbatim_location                       :text
#  calculation_of_number_of_people_reached :text
#  project_needs                           :text
#  idprefugee_camp                         :text
#

class Project < ActiveRecord::Base
  include ModelChangesRecorder

  belongs_to :primary_organization, :foreign_key => :primary_organization_id, :class_name => 'Organization'
  has_and_belongs_to_many :clusters
  has_and_belongs_to_many :sectors
  has_and_belongs_to_many :regions, :after_add => :add_to_country, :after_remove => :remove_from_country
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :tags, :after_add => :update_tag_counter, :after_remove => :update_tag_counter
  has_many :resources, :conditions => 'resources.element_type = #{Iom::ActsAsResource::PROJECT_TYPE}', :foreign_key => :element_id, :dependent => :destroy
  has_many :media_resources, :conditions => 'media_resources.element_type = #{Iom::ActsAsResource::PROJECT_TYPE}', :foreign_key => :element_id, :dependent => :destroy, :order => 'position ASC'
  has_many :donations, :dependent => :destroy
  has_many :donors, :through => :donations
  has_many :cached_sites, :class_name => 'Site', :finder_sql => 'select sites.* from sites, projects_sites where projects_sites.project_id = #{id} and projects_sites.site_id = sites.id'

  scope :active, where("end_date > ?", Date.today.to_s(:db))
  scope :closed, where("end_date < ?", Date.today.to_s(:db))
  scope :with_no_country, select('projects.*').
                          joins(:regions).
                          includes(:countries).
                          where('countries_projects.project_id IS NULL AND regions.id IS NOT NULL')

  attr_accessor :sync_errors, :sync_mode, :location

  validate :sync_mode_validations,                                   :if     => lambda { sync_mode }
  validates_presence_of :name, :description, :start_date, :end_date, :unless => lambda { sync_mode }
  validates_presence_of :primary_organization_id,                    :unless => lambda { sync_mode }
  validate :location_presence,                                       :unless => lambda { sync_mode }
  validate :dates_consistency#, :presence_of_clusters_and_sectors

  #validates_uniqueness_of :intervention_id, :if => (lambda do
    #intervention_id.present?
  #end)

  after_create :generate_intervention_id
  after_commit :set_cached_sites
  after_destroy :remove_cached_sites

  def tags=(tag_names)
    if tag_names.blank?
      tags.clear
      return
    end
    if tag_names.is_a?(String)
      tag_names = tag_names.split(/[\||,]/).map{ |t| t.strip }.compact.delete_if{ |t| t.blank? }
    end
    Tag.transaction do
      tags.clear
      tag_names.each do |tag_name|
        if tag = Tag.find_by_name(tag_name)
          unless tags.include?(tag)
            tags << tag
          end
        else
          tag = Tag.create :name => tag_name
          tags << tag
        end
      end
    end
  end

  def budget=(ammount)
    if ammount.blank?
      write_attribute(:budget, 0)
    else
      case ammount
        when String then write_attribute(:budget, ammount.delete(',').to_f)
        else             write_attribute(:budget, ammount)
      end
    end
  end

  def estimated_people_reached=(ammount)
    if ammount.blank?
      write_attribute(:estimated_people_reached, 0)
    else
      case ammount
        when String then write_attribute(:estimated_people_reached, ammount.delete(',').to_f)
        else             write_attribute(:estimated_people_reached, ammount)
      end
    end
  end

  def points=(value)
    points = value.map do |point|
      point = point.tr('(','').tr(')','').split(',')
      Point.from_x_y(point[1].strip.to_f, point[0].strip.to_f)
    end
    self.the_geom = MultiPoint.from_points(points)
  end

  def date_provided=(value)
    if value.present?
      value = case value
              when String
                Date.parse(value)
              when Date, Time, DateTime
                value
              end
      write_attribute(:date_provided, value)
    end
  end

  def date_updated=(value)
    if value.present?
      value = case value
              when String
                Date.parse(value)
              when Date, Time, DateTime
                value
              end
      write_attribute(:date_updated, value)
    end
  end

  def update_tag_counter(tag)
    tag.update_tag_counter
  end

  def finished?
    if (!end_date.nil?)
      end_date < Date.today
    else
      false
    end
  end

  def months_left
    unless finished? || end_date.nil?
      (end_date - Date.today).to_i / 30
    else
      nil
    end
  end

  def to_kml
    the_geom.as_kml if the_geom.present?
  end

  def self.export_headers(options = {})
    options = {:show_private_fields => false}.merge(options || {})

    if options[:show_private_fields]
      %w(organization interaction_intervention_id org_intervention_id project_tags project_name project_description activities additional_information start_date end_date clusters sectors cross_cutting_issues budget_numeric international_partners local_partners prime_awardee estimated_people_reached target_groups location verbatim_location idprefugee_camp project_contact_person project_contact_position project_contact_email project_contact_phone_number project_website date_provided date_updated status donors)
    else
      %w(organization interaction_intervention_id org_intervention_id project_tags project_name project_description activities additional_information start_date end_date clusters sectors cross_cutting_issues budget_numeric international_partners local_partners prime_awardee estimated_people_reached target_groups location project_contact_person project_contact_position project_contact_email project_contact_phone_number project_website date_provided date_updated status donors)
    end
  end

  def self.list_for_export(site = nil, options = {})
    where = []

    where << "(cp.country_id IS NOT NULL OR pr.region_id IS NOT NULL)"
    where << "site_id = #{site.id}" if site

    where << '(p.end_date is null OR p.end_date > now())' if !options[:include_non_active]



    if options[:kml]
      kml_select = <<-SQL
        , CASE WHEN regions_ids IS NOT NULL AND regions_ids != ('{}')::integer[] THEN
        (select
        '<MultiGeometry><Point><coordinates>'|| array_to_string(array_agg(distinct center_lon ||','|| center_lat),'</coordinates></Point><Point><coordinates>') || '</coordinates></Point></MultiGeometry>' as lat
        from regions as r INNER JOIN projects_regions AS pr ON r.id=pr.region_id where ('{'||r.id||'}')::integer[] && regions_ids and pr.project_id=p.id)
        ELSE
        (select
        '<MultiGeometry><Point><coordinates>'|| array_to_string(array_agg(distinct center_lon ||','|| center_lat),'</coordinates></Point><Point><coordinates>') || '</coordinates></Point></MultiGeometry>' as lat
        from countries as c INNER JOIN countries_projects AS cp ON c.id=cp.country_id where ('{'||c.id||'}')::integer[] && countries_ids and cp.project_id=p.id)
        END
        as kml
      SQL
      kml_group_by = <<-SQL
        countries_ids,
        regions_ids,
      SQL
    end

    if options[:region]
      where << "regions_ids && '{#{options[:region]}}' and site_id=#{site.id}"
      if options[:region_category_id]
        if site.navigate_by_cluster?
          where << "cluster_ids && '{#{options[:region_category_id]}}'"
        else
          where << "sector_ids && '{#{options[:region_category_id]}}'"
        end
      end
    elsif options[:country]
      where << "countries_ids && '{#{options[:country]}}' and site_id=#{site.id}"
      if options[:country_category_id]
        if site.navigate_by_cluster?
          where << "cluster_ids && '{#{options[:country_category_id]}}'"
        else
          where << "sector_ids && '{#{options[:country_category_id]}}'"
        end
      end
    elsif options[:cluster]
      where << "cluster_ids && '{#{options[:cluster]}}' and site_id=#{site.id}"
      where << "regions_ids && '{#{options[:cluster_region_id]}}'" if options[:cluster_region_id]
      where << "countries_ids && '{#{options[:cluster_country_id]}}'" if options[:cluster_country_id]
    elsif options[:sector]
      where << "sector_ids && '{#{options[:sector]}}' and site_id=#{site.id}"
      where << "regions_ids && '{#{options[:sector_region_id]}}'" if options[:sector_region_id]
      where << "countries_ids && '{#{options[:sector_country_id]}}'" if options[:sector_country_id]
    elsif options[:organization]
      where << "p.primary_organization_id = #{options[:organization]}"
      where << "site_id=#{site.id}" if site

      if options[:organization_category_id]
        if site.navigate_by_cluster?
          where << "cluster_ids && '{#{options[:organization_category_id]}}'"
        else
          where << "sector_ids && '{#{options[:organization_category_id]}}'"
        end
      end

      where << "regions_ids && '{#{options[:organization_region_id]}}'::integer[]" if options[:organization_region_id]
      where << "countries_ids && '{#{options[:organization_country_id]}}'::integer[]" if options[:organization_country_id]
    elsif options[:project]
      where << "project_id = #{options[:project]}"
    end

    where = "WHERE #{where.join(' AND ')}" if where.present?


    sql = <<-SQL
      WITH r3 AS (SELECT r3.id, c.name || '>' || r1.name || '>' || r2.name || '>' || r3.name AS name
                    FROM regions r3
                    INNER JOIN regions r2 ON r3.parent_region_id = r2.id
                    INNER JOIN regions r1 ON r2.parent_region_id = r1.id
                    INNER JOIN countries c ON r1.country_id = c.id
                  ),
                  r2 AS (SELECT r2.id, c.name || '>' || r1.name || '>' || r2.name AS name
                    FROM regions r2
                    INNER JOIN regions r1 ON r2.parent_region_id = r1.id
                    INNER JOIN countries c ON r1.country_id = c.id
                  ),
                  r1 AS (SELECT r1.id, c.name || '>' || r1.name AS name
                    FROM regions r1
                    INNER JOIN countries c ON r1.country_id = c.id),
                  c AS (SELECT c.id, c.name AS name
                    from countries c
                  )


        SELECT DISTINCT
        p.id,
        p.name as project_name,
        p.description as project_description,
        primary_organization_id,
        o.name AS organization,
        implementing_organization as international_partners,
        partner_organizations AS local_partners,
        cross_cutting_issues,
        p.start_date,
        p.end_date,
        CASE WHEN p.budget=0 THEN null ELSE p.budget END AS budget_numeric,
        target as target_groups,
        p.estimated_people_reached,
        contact_person AS project_contact_person,
        p.contact_email AS project_contact_email,
        p.contact_phone_number AS project_contact_phone_number,
        activities,
        intervention_id,
        intervention_id as interaction_intervention_id,
        additional_information,
        awardee_type as prime_awardee,
        date_provided,
        date_updated,
        p.contact_position AS project_contact_position,
        p.website AS project_website,
        verbatim_location,
        (SELECT '|' || array_to_string(array_agg(distinct name),'|') ||'|' FROM sectors AS s INNER JOIN projects_sectors AS ps ON s.id=ps.sector_id WHERE ps.project_id=p.id) AS sectors,
        (SELECT '|' || array_to_string(array_agg(distinct name),'|') ||'|' FROM clusters AS c INNER JOIN clusters_projects AS cp ON c.id=cp.cluster_id WHERE cp.project_id=p.id) AS clusters,
        '|' || array_to_string(array_agg(distinct ps.site_id),'|') ||'|' as site_ids,
        array_to_string(
          array_agg(
            distinct CASE WHEN r3.name is not null THEN r3.name
                          WHEN r2.name is not null THEN r2.name
                          WHEN r1.name is not null THEN r1.name
                          WHEN c.name is not null THEN c.name
                          END
            ),'|'
        ) as location,
        (SELECT '|' || array_to_string(array_agg(distinct name),'|') ||'|' FROM tags AS t INNER JOIN projects_tags AS pt ON t.id=pt.tag_id WHERE pt.project_id=p.id) AS project_tags,
        (SELECT '|' || array_to_string(array_agg(distinct name),'|') ||'|' FROM donors AS d INNER JOIN donations AS dn ON d.id=dn.donor_id AND dn.project_id=p.id) AS donors,
        p.organization_id as org_intervention_id,
        CASE WHEN p.end_date > current_date THEN 'active' ELSE 'closed' END AS status
        #{kml_select}
        FROM projects AS p
        LEFT OUTER JOIN organizations o        ON  o.id = p.primary_organization_id
        LEFT OUTER JOIN projects_sites ps      ON  ps.project_id = p.id
        LEFT OUTER JOIN countries_projects cp  ON  cp.project_id = p.id
        LEFT OUTER JOIN c                      ON  cp.country_id = c.id
        LEFT OUTER JOIN projects_regions pr    ON  pr.project_id = p.id
        LEFT OUTER JOIN r1                     ON  pr.region_id = r1.id
        LEFT OUTER JOIN r2                     ON  pr.region_id = r2.id
        LEFT OUTER JOIN r3                     ON  pr.region_id = r3.id
        #{where}
        GROUP BY
        p.id,
        p.name,
        p.description,
        primary_organization_id,
        o.name,
        implementing_organization,
        partner_organizations,
        cross_cutting_issues,
        p.start_date,
        p.end_date,
        p.budget,
        target,
        p.estimated_people_reached,
        contact_person,
        p.contact_email,
        p.contact_phone_number,
        activities,
        intervention_id,
        p.organization_id,
        additional_information,
        awardee_type,
        date_provided,
        date_updated,
        p.contact_position,
        p.website,
        verbatim_location,
        idprefugee_camp,
        status,
        #{kml_group_by}
        sectors,
        clusters
        ORDER BY interaction_intervention_id
    SQL
    ActiveRecord::Base.connection.execute(sql)
  end

  def self.to_csv(site, options = {})
    projects = self.list_for_export(site, options)
    csv_headers = self.export_headers(options[:headers_options])

    csv_data = FasterCSV.generate(:col_sep => ',') do |csv|
      csv << csv_headers
      projects.each do |project|
        line = []
        csv_headers.each do |field_name|
          v = project[field_name]
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
    csv_data
  end

  def self.to_excel(site, options = {})
    projects = self.list_for_export(site, options)
    projects.to_excel(:headers => self.export_headers(options[:headers_options]))
  end

  def self.to_kml(site, options = {})
    projects = self.list_for_export(site, options.merge(:kml => true))
  end

  def related(site, limit = 2)
    result = ActiveRecord::Base.connection.execute(<<-SQL
      select project_id,project_name,organization_id,organization_name,
      (select name from regions where id=regions_ids[1]) as region_name,
      (select center_lat from regions where id=regions_ids[1]) as center_lat,
      (select center_lon from regions where id=regions_ids[1]) as center_lon,
      (select path from regions where id=regions_ids[1]) as path
      from data_denormalization where
      organization_id = #{self.primary_organization_id}
      and project_id!=#{self.id} and site_id=#{site.id} and (end_date is null OR end_date > now())
      and (select center_lat from regions where id=regions_ids[1]) is not null
      limit #{limit}
SQL
    )
    return result unless result.count<1
    # If there are not close projects try with projects of a different organization
        result = ActiveRecord::Base.connection.execute(<<-SQL
          select project_id,project_name,organization_id,organization_name,
          (select name from regions where id=regions_ids[1]) as region_name,
          (select center_lat from regions where id=regions_ids[1]) as center_lat,
          (select center_lon from regions where id=regions_ids[1]) as center_lon,
          (select path from regions where id=regions_ids[1]) as path
          from data_denormalization where
          regions_ids && (select ('{'||array_to_string(array_agg(region_id),',')||'}')::integer[] as regions_ids from projects_regions where project_id=#{self.id})
          and project_id!=#{self.id} and site_id=#{site.id} and (end_date is null OR end_date > now())
          and (select center_lat from regions where id=regions_ids[1]) is not null
          limit #{limit}
SQL
    )
    return result unless result.count<1
        result = ActiveRecord::Base.connection.execute(<<-SQL
          select project_id,project_name,organization_id,organization_name,
          (select name from regions where id=regions_ids[1]) as region_name,
          (select center_lat from regions where id=regions_ids[1]) as center_lat,
          (select center_lon from regions where id=regions_ids[1]) as center_lon,
          (select path from regions where id=regions_ids[1]) as path
          from data_denormalization where
          project_id!=#{self.id} and site_id=#{site.id} and (end_date is null OR end_date > now())
          limit #{limit}
SQL
    )
  end

  def self.custom_find(site, options = {})
    default_options = {
      :order => 'project_id DESC',
      :random => true,
    }
    options = default_options.merge(options)
    options[:page] ||= 1
    level = options[:level] ? options[:level] : site.levels_for_region.max

    sql = ""
    if options[:region]
      where = []
      where << "regions_ids && '{#{options[:region]}}' and site_id=#{site.id} and (end_date is null OR end_date > now())"
      if options[:region_category_id]
        if site.navigate_by_cluster?
          where << "cluster_ids && '{#{options[:region_category_id]}}'"
        else
          where << "sector_ids && '{#{options[:region_category_id]}}'"
        end
      end

      sql="select * from data_denormalization where #{where.join(' and ')}"
    elsif options[:country]
      where = []
      where << "countries_ids && '{#{options[:country]}}' and site_id=#{site.id} and (end_date is null OR end_date > now())"
      if options[:country_category_id]
        if site.navigate_by_cluster?
          where << "cluster_ids && '{#{options[:country_category_id]}}'"
        else
          where << "sector_ids && '{#{options[:country_category_id]}}'"
        end
      end

      sql="select * from data_denormalization where #{where.join(' and ')}"
    elsif options[:cluster]
      where = []
      where << "cluster_ids && '{#{options[:cluster]}}' and site_id=#{site.id} and (end_date is null OR end_date > now())"
      where << "regions_ids && '{#{options[:cluster_region_id]}}'" if options[:cluster_region_id]
      where << "countries_ids && '{#{options[:cluster_country_id]}}'" if options[:cluster_country_id]

      sql="select * from data_denormalization where #{where.join(' and ')}"
    elsif options[:sector]
      where = []
      where << "sector_ids && '{#{options[:sector]}}' and site_id=#{site.id} and (end_date is null OR end_date > now())"
      where << "regions_ids && '{#{options[:sector_region_id]}}'" if options[:sector_region_id]
      where << "countries_ids && '{#{options[:sector_country_id]}}'" if options[:sector_country_id]

      sql="select * from data_denormalization where #{where.join(' and ')}"
    elsif options[:organization]
      where = []
      where << "organization_id = #{options[:organization]} and site_id=#{site.id} and (end_date is null OR end_date > now())"

      if options[:organization_category_id]
        if site.navigate_by_cluster?
          where << "cluster_ids && '{#{options[:organization_category_id]}}'"
        else
          where << "sector_ids && '{#{options[:organization_category_id]}}'"
        end
      end

      where << "regions_ids && '{#{options[:organization_region_id]}}'::integer[]" if options[:organization_region_id]
      where << "countries_ids && '{#{options[:organization_country_id]}}'::integer[]" if options[:organization_country_id]

      sql="select * from data_denormalization where #{where.join(' and ')}"
    elsif options[:donor_id]
      sql="select * from data_denormalization where donors_ids && '{#{options[:donor_id]}}' and site_id=#{site.id} and (end_date is null OR end_date > now())"
    else
      sql="select * from data_denormalization where site_id=#{site.id} and (end_date is null OR end_date > now())"
    end

    total_entries = ActiveRecord::Base.connection.execute("select count(*) as count from (#{sql}) as q").first['count'].to_i

    total_pages = (total_entries.to_f / options[:per_page].to_f).ceil

    start_in_page = if options[:start_in_page]
      options[:start_in_page].to_i
    else
      if total_pages
        if total_pages > 2
          rand(total_pages - 1)
        else
          0
        end
      else
        0
      end
    end

    if options[:order]
      sql << " ORDER BY #{options[:order]}"
    end
    # Let's query an extra result: if it exists, whe have to show the paginator link "More projects"
    if options[:per_page]
      sql << " LIMIT #{options[:per_page].to_i}"
    end
    if options[:page] && options[:per_page]
      #####
      # start_in_page =  4
      # total_pages   =  7
      # per_page      = 10
      #
      # page = 1 > real page = 5 > offset = 40
      # page = 2 > real page = 6 > offset = 50
      # page = 3 > real page = 7 > offset = 60
      # page = 4 > real page = 1 > offset = 0
      # page = 5 > real page = 2 > offset = 10

      # Apparently, the offset is not being calculated correctly
      #offset = if (options[:page].to_i + start_in_page - 1) <= total_pages
        #options[:per_page].to_i * (options[:page].to_i + start_in_page - 1)
      #else
        #options[:per_page].to_i * (options[:page].to_i - start_in_page)
      #end
      #
      offset = (options[:page].to_i - 1) * options[:per_page].to_i
      raise Iom::InvalidOffset if offset < 0
      sql << " OFFSET #{offset}"
    end
    result = ActiveRecord::Base.connection.execute(sql).map{ |r| r }
    page = Integer(options[:page]) rescue 1

    WillPaginate::RandomCollection.create(page, options[:per_page], total_entries, page - 1) do |pager|
      pager.replace(result)
    end
  end

  def self.custom_fields
    (columns.map{ |c| c.name }).map{ |c| "#{self.table_name}.#{c}" }
  end

  def the_geom_to_value
    return "" if the_geom.blank? || !the_geom.respond_to?(:points)
    the_geom.points.map do |point|
      "(#{point.y} #{point.x})"
    end.join(',')
  end

  def countries_ids
    return "" if self.new_record?
    sql = "select country_id from countries_projects where project_id=#{self.id}"
    ActiveRecord::Base.connection.execute(sql).map{ |r| r['country_id'] }.join(',')
  end

  def regions_hierarchized
    return "" if self.new_record?
    level = 3
    result_regions = []
    all_regions = Region.find_by_sql("select #{Region.custom_fields.join(',')} from regions inner join projects_regions on projects_regions.region_id=regions.id where project_id=#{self.id}")
    all_countries = Country.find_by_sql("select #{Country.custom_fields.join(',')} from countries inner join countries_projects on countries_projects.country_id=countries.id where project_id=#{self.id}")
    while all_regions.any?
      result_regions += all_regions.select{ |r| r.level == level }
      all_regions = all_regions - result_regions
      parent_region_ids = result_regions.map do |region|
        region.path.split('/')[1..-1].map{ |e| e.to_i }
      end.flatten
      parent_countries_ids = result_regions.map do |region|
        region.path.split('/').first.to_i
      end.flatten
      all_regions = all_regions.delete_if{ |r| parent_region_ids.include?(r.id) }
      all_countries = all_countries.delete_if{ |c| parent_countries_ids.include?(c.id) }
      level -= 1
    end
    all_countries + result_regions
  end

  def regions_ids
    return "" if self.new_record?
    sql = "select region_id from projects_regions where project_id=#{self.id}"
    ActiveRecord::Base.connection.execute(sql).map{ |r| r['region_id'] }.uniq.join(',')
  end

  def regions_ids=(value)
    country_ids = []
    region_ids = []
    value.each do |country_or_region|
      if country_or_region =~ /^country/
        country_ids += [country_or_region.split('_').last.to_i]
      elsif country_or_region =~ /^region/
        region = Region.find(country_or_region.split('_').last, :select => "id,name,path")
        country_ids += [region.path.split('/').first.to_i]
        region_ids += region.path.split('/')[1..-1].map{ |e| e.to_i}
      end
    end
    self.country_ids = country_ids.uniq
    self.region_ids = region_ids.uniq
  end

  def set_cached_sites

    #We also update its geometry
    sql = <<-SQL
      UPDATE projects p SET the_geom = geoms.the_geom
      FROM (
        SELECT ST_Collect(r.the_geom) AS the_geom, proj.id
        FROM
        projects proj
        INNER JOIN projects_regions pr ON pr.project_id = proj.id
        INNER JOIN regions r ON pr.region_id = r.id
        GROUP BY proj.id
      ) AS geoms
      WHERE p.id = geoms.id
    SQL
    ActiveRecord::Base.connection.execute(sql)

    sql = <<-SQL
      UPDATE projects p SET the_geom = geoms.the_geom
      FROM
      (
        SELECT ST_Collect(ST_SetSRID(ST_Point(c.center_lon, c.center_lat), 4326)) AS the_geom, proj.id
        FROM
        projects proj
        INNER JOIN countries_projects cp ON cp.project_id = proj.id
        INNER JOIN countries c ON cp.country_id = c.id
        GROUP BY proj.id
      ) AS geoms,
      (
        SELECT proj.id
        FROM projects proj
        LEFT OUTER JOIN projects_regions pr ON pr.project_id = proj.id
        WHERE pr.project_id IS NULL
      ) projects_without_regions
      WHERE p.id = geoms.id AND  p.id = projects_without_regions.id
    SQL
    ActiveRecord::Base.connection.execute(sql)

    remove_cached_sites

    Site.all.each do |site|
      if site.projects.map(&:id).include?(self.id)
        sql = "insert into projects_sites (project_id, site_id) values (#{self.id}, #{site.id})"
        ActiveRecord::Base.connection.execute(sql)
        sql = "insert into data_denormalization(project_id,project_name,project_description,organization_id,organization_name,end_date,regions,regions_ids,countries,countries_ids,sectors,sector_ids,clusters,cluster_ids,donors_ids,is_active,site_id,created_at)
        select  * from
               (SELECT p.id as project_id, p.name as project_name, p.description as project_description,
               o.id as organization_id, o.name as organization_name,
               p.end_date as end_date,
               '|'||array_to_string(array_agg(distinct r.name),'|')||'|' as regions,
               ('{'||array_to_string(array_agg(distinct r.id),',')||'}')::integer[] as regions_ids,
               '|'||array_to_string(array_agg(distinct c.name),'|')||'|' as countries,
               ('{'||array_to_string(array_agg(distinct c.id),',')||'}')::integer[] as countries_ids,
               '|'||array_to_string(array_agg(distinct sec.name),'|')||'|' as sectors,
               ('{'||array_to_string(array_agg(distinct sec.id),',')||'}')::integer[] as sector_ids,
               '|'||array_to_string(array_agg(distinct clus.name),'|')||'|' as clusters,
               ('{'||array_to_string(array_agg(distinct clus.id),',')||'}')::integer[] as cluster_ids,
               ('{'||array_to_string(array_agg(distinct d.donor_id),',')||'}')::integer[] as donors_ids,
               CASE WHEN end_date is null OR p.end_date > now() THEN true ELSE false END AS is_active,
               ps.site_id,p.created_at
               FROM projects as p
               INNER JOIN organizations as o ON p.primary_organization_id=o.id
               INNER JOIN projects_sites as ps ON p.id=ps.project_id
               LEFT JOIN projects_regions as pr ON pr.project_id=p.id
               LEFT JOIN regions as r ON pr.region_id=r.id and r.level=#{site.level_for_region}
               LEFT JOIN countries_projects as cp ON cp.project_id=p.id
               LEFT JOIN countries as c ON c.id=cp.country_id
               LEFT JOIN clusters_projects as cpro ON cpro.project_id=p.id
               LEFT JOIN clusters as clus ON clus.id=cpro.cluster_id
               LEFT JOIN projects_sectors as psec ON psec.project_id=p.id
               LEFT JOIN sectors as sec ON sec.id=psec.sector_id
               LEFT JOIN donations as d ON d.project_id=ps.project_id
               where site_id=#{site.id} AND p.id=#{self.id}
               GROUP BY p.id,p.name,o.id,o.name,p.description,p.end_date,ps.site_id,p.created_at) as subq"
         ActiveRecord::Base.connection.execute(sql)

         #We also take the opportunity to add to denormalization the projects which are orphan from a site
         #Those projects not in a site right now also need to be handled for exports
         sql_for_orphan_projects = """
            insert into data_denormalization(project_id,project_name,project_description,organization_id,organization_name,
            start_date,end_date,regions,regions_ids,countries,countries_ids,sectors,sector_ids,clusters,cluster_ids,
            donors_ids,is_active,created_at)
            select  * from
              (SELECT p.id as project_id, p.name as project_name, p.description as project_description,
                    o.id as organization_id, o.name as organization_name,
                    p.start_date as start_date ,
                    p.end_date as end_date,
                    '|'||array_to_string(array_agg(distinct r.name),'|')||'|' as regions,
                    ('{'||array_to_string(array_agg(distinct r.id),',')||'}')::integer[] as regions_ids,
                    '|'||array_to_string(array_agg(distinct c.name),'|')||'|' as countries,
                    ('{'||array_to_string(array_agg(distinct c.id),',')||'}')::integer[] as countries_ids,
                    '|'||array_to_string(array_agg(distinct sec.name),'|')||'|' as sectors,
                    ('{'||array_to_string(array_agg(distinct sec.id),',')||'}')::integer[] as sector_ids,
                    '|'||array_to_string(array_agg(distinct clus.name),'|')||'|' as clusters,
                    ('{'||array_to_string(array_agg(distinct clus.id),',')||'}')::integer[] as cluster_ids,
                    ('{'||array_to_string(array_agg(distinct d.donor_id),',')||'}')::integer[] as donors_ids,
                    CASE WHEN end_date is null OR p.end_date > now() THEN true ELSE false END AS is_active,
                    p.created_at
                    FROM projects as p
                    INNER JOIN organizations as o ON p.primary_organization_id=o.id
                    LEFT JOIN projects_regions as pr ON pr.project_id=p.id
                    LEFT JOIN regions as r ON pr.region_id=r.id
                    LEFT JOIN countries_projects as cp ON cp.project_id=p.id
                    LEFT JOIN countries as c ON c.id=cp.country_id
                    LEFT JOIN clusters_projects as cpro ON cpro.project_id=p.id
                    LEFT JOIN clusters as clus ON clus.id=cpro.cluster_id
                    LEFT JOIN projects_sectors as psec ON psec.project_id=p.id
                    LEFT JOIN sectors as sec ON sec.id=psec.sector_id
                    LEFT JOIN donations as d ON d.project_id=p.id
                    where p.id not in (select project_id from projects_sites)
                    GROUP BY p.id,p.name,o.id,o.name,p.description,p.start_date,p.end_date,p.created_at) as subq"""
         ActiveRecord::Base.connection.execute(sql_for_orphan_projects)

      end

    end

    Rails.cache.clear

  end

  def remove_cached_sites
    Site.all.each do |site|
      sql = "delete from projects_sites where project_id=#{self.id}"
      ActiveRecord::Base.connection.execute(sql)
      sql = "delete from data_denormalization where project_id=#{self.id}"
      ActiveRecord::Base.connection.execute(sql)
      ActiveRecord::Base.connection.execute("DELETE FROM data_denormalization WHERE site_id = null")
    end
  end

  def update_countries_from_regions
    regions_countries = regions.map(&:country).uniq
    self.countries = regions_countries
    save!
  end

  def generate_intervention_id
    Project.where(:id => id).update_all(:intervention_id => [
      primary_organization.try(:organization_id).presence || 'XXXX',
      countries.first.try(:iso2_code).presence || 'XX',
      start_date.strftime('%y'),
      id
    ].join('-'))
  end

  def create_intervention_id
    generate_intervention_id
    update_attribute(:intervention_id, intervention_id)
  end

  def update_intervention_id
    generate_intervention_id if Project.where('intervention_id = ? AND id <> ?', intervention_id, id).count > 0
  end

  ##############################
  # PROJECT SYNCHRONIZATION

  def sync_errors
    @sync_errors ||= []
  end

  def sync_line=(value)
    @sync_line = value
  end

  def project_name_sync=(value)
    self.name = value
  end

  def project_description_sync=(value)
    self.description = value
  end

  def org_intervention_id_sync=(value)
    self.organization_id = value
  end

  def international_partners_sync=(value)
    self.implementing_organization = value
  end

  def local_partners_sync=(value)
    self.partner_organizations = value
  end

  def budget_numeric_sync=(value)
    @budget = value
  end

  def target_groups_sync=(value)
    self.target = value
  end

  def project_contact_person_sync=(value)
    self.contact_person = value
  end

  def project_contact_email_sync=(value)
    self.contact_email = value
  end

  def project_contact_phone_number_sync=(value)
    self.contact_phone_number = value
  end

  def interaction_intervention_id_sync=(value)
  end

  def prime_awardee_sync=(value)
    self.awardee_type = value
  end

  def project_contact_position_sync=(value)
    self.contact_position = value
  end

  def project_website_sync=(value)
    self.website = value
  end

  def activities_sync=(value)
    self.activities = value
  end

  def additional_information_sync=(value)
    self.additional_information = value
  end

  def start_date_sync=(value)
    self.start_date = value
  end

  def end_date_sync=(value)
    self.end_date = value
  end

  def cross_cutting_issues_sync=(value)
    self.cross_cutting_issues = value
  end

  def estimated_people_reached_sync=(value)
    @estimated_people_reached_sync = value
  end

  def verbatim_location_sync=(value)
    self.verbatim_location = value
  end

  def idprefugee_camp_sync=(value)
    self.idprefugee_camp = value
  end

  def date_provided_sync=(value)
  end

  def date_updated_sync=(value)
  end

  def status_sync=(value)
  end

  def project_tags_sync=(value)
    self.tags = value
  end

  def organization_sync=(value)
    @organization_name = value || ''
  end

  def location_sync=(value)
    @location_sync = value || []
  end

  def sectors_sync=(value)
    @sectors_sync = value || []
  end

  def clusters_sync=(value)
    @clusters_sync = value || []
  end

  def donors_sync=(value)
    @donors_sync = value || []
  end

  def sync_mode_validations
    self.date_provided = Time.now.to_date if new_record?

    errors.add(:name,        :blank ) if name.blank?
    errors.add(:description, :blank ) if description.blank?
    errors.add(:start_date,  :blank ) if start_date.blank?
    errors.add(:end_date,    :blank ) if end_date.blank?

    begin
      self.budget = Float(@budget)
    rescue
      errors.add(:budget, "only accepts numeric values")
    end if @budget.present?

    self.start_date = case start_date
                      when Date, DateTime, Time
                        start_date
                      when String
                        Date.parse(start_date) rescue self.errors.add(:start_date, "Start date is invalid")
                      else
                        self.errors.add(:start_date, "Start date is invalid")
                      end if start_date.present?

    self.end_date = case end_date
                    when Date, DateTime, Time
                      end_date
                    when String
                      Date.parse(end_date) rescue self.errors.add(:end_date, "End date is invalid")
                    else
                      self.errors.add(:end_date, "End date is invalid")
                    end if end_date.present?

    self.date_provided = Time.now if new_record?
    self.date_updated = Time.now

    begin
      self.estimated_people_reached = Float(@estimated_people_reached_sync)
    rescue
      self.errors.add(:estimated_people_reached, "only accepts numeric values")
    end if @estimated_people_reached_sync.present?

    if @organization_name && (organization = Organization.where('lower(trim(name)) = lower(trim(?))', @organization_name).first) && organization.present?
      self.primary_organization_id = organization.id
    else
      self.errors.add(:organization, %Q{"#{@organization_name}" doesn't exist})
    end if new_record?


    if @location_sync
      self.countries.clear
      self.regions.clear

      if @location_sync.present? && (locations = @location_sync.text2array)
        locations.each do |location|
          country_name, *regions = location.split('>')

          if country_name
            country = Country.where('lower(trim(name)) = lower(trim(?))', country_name).first
            if country.blank?
              self.sync_errors << "Country #{country_name} doesn't exist on row #@sync_line"
            else
              self.countries << country unless self.countries.include?(country)
            end
          end

          if regions.present?
            regions.each_with_index do |region_name, level|
              level += 1

              region = Region.where('lower(trim(name)) = lower(trim(?))', region_name).first
              if region.blank?
                self.sync_errors << "#{level.ordinalize} Admin level #{region_name} doesn't exist on row #@sync_line"
                next
              end
              self.regions << region unless self.regions.include?(region)
            end
          end
        end
      end
    end

    if @sectors_sync
      self.sectors.clear
      if @sectors_sync.present? && (sectors = @sectors_sync.text2array)
        sectors.each do |sector_name|
          sector = Sector.where('lower(trim(name)) = lower(trim(?))', sector_name).first
          if sector.blank? && new_record?
            errors.add(:sector,  "#{sector_name} doesn't exist")
            next
          end
          self.sectors << sector
        end
      end
    end

    if @clusters_sync
      self.clusters.clear
      if @clusters_sync.present? && (clusters = @clusters_sync.text2array)
        clusters.each do |cluster_name|
          cluster = Cluster.where('lower(trim(name)) = lower(trim(?))', cluster_name).first
          if cluster.blank?
            errors.add(:cluster,  "#{cluster_name} doesn't exist")
            next
          end
          self.clusters << cluster
        end
      end
    end

    if @donors_sync
      self.donors.clear
      if @donors_sync.present? && (donors = @donors_sync.text2array)
        donors.each do |donor_name|
          donor = Donor.where('lower(trim(name)) = lower(trim(?))', donor_name)
          if donor.blank?
            errors.add(:donor,  "#{donor_name} doesn't exist")
            next
          end
          self.donors << donor
        end
      end
    end

    errors.add(:sectors, :blank)                 if (new_record? && self.sectors.blank?) || (@sectors_sync && @sectors_sync.empty?)
    errors.add(:location, :blank)                if (new_record? && self.countries.blank? && self.regions.blank?) || (@location_sync && @location_sync.empty?)
    errors.add(:primary_organization_id, :blank) if (new_record? && self.primary_organization_id.blank?) || (@organization_name && @organization_name.empty?)
  end

  # PROJECT SYNCHRONIZATION
  ##############################

  private

  def location_presence
    return true if region_ids.present? || country_ids.present?
    errors.add(:location, 'Sorry, location information is mandatory') if region_ids.blank? && country_ids.blank?
  end

  def dates_consistency
    return true if end_date.nil? || start_date.nil?
    if start_date.present? && start_date > 1.week.since.to_date
      errors.add(:start_date, "max 1 week from today")
    end
    if !end_date.nil? && !start_date.nil? && end_date < start_date
      errors.add(:end_date, "can't be previous to start_date")
    end
    if !date_updated.nil? && !date_provided.nil? && date_updated < date_provided
      errors.add(:date_updated, "can't be previous to date_provided")
    end
  end

  def add_to_country(region)
    return if self.new_record?
    count = ActiveRecord::Base.connection.execute("select count(*) as count from countries_projects where project_id=#{self.id} AND country_id=#{region.country_id}").first['count'].to_i
    if count == 0
      ActiveRecord::Base.connection.execute("INSERT INTO countries_projects (project_id, country_id) VALUES (#{self.id},#{region.country_id})")
    end
  end

  def remove_from_country(region)
    ActiveRecord::Base.connection.execute("DELETE from countries_projects where project_id=#{self.id} AND country_id=#{region.country_id}")
  end

  def presence_of_clusters_and_sectors
    return unless self.new_record?
    if sectors_ids.blank? && sectors.empty?
      errors.add(:sectors, "can't be blank")
    end
    if clusters_ids.blank? && clusters.empty?
      errors.add(:clusters, "can't be blank")
    end
  end
end
