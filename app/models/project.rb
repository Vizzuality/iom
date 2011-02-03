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
#  estimated_people_reached                :integer
#  contact_person                          :string(255)
#  contact_email                           :string(255)
#  contact_phone_number                    :string(255)
#  site_specific_information               :text
#  created_at                              :datetime
#  updated_at                              :datetime
#  the_geom                                :string          not null
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

  validates_presence_of :primary_organization_id, :name

  validate :dates_consistency#, :presence_of_clusters_and_sectors

  after_save :set_cached_sites
  after_destroy :remove_cached_sites

  def tags=(tag_names)
    return if tag_names.blank?
    if tag_names.is_a?(String)
      tag_names = tag_names.split(',').map{ |t| t.strip }.compact.delete_if{ |t| t.blank? }
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

  def points=(value)
    points = value.map do |point|
      point = point.tr('(','').tr(')','').split(',')
      Point.from_x_y(point[1].strip.to_f, point[0].strip.to_f)
    end
    self.the_geom = MultiPoint.from_points(points)
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

  # execute "CREATE TABLE data_denormalization
  # (
  #   project_id integer,
  #   project_name character varying(2000),
  #   project_description text,
  #   organization_id integer,
  #   organization_name character varying(2000),
  #   end_date date,
  #   regions text,
  #   regions_ids integer[],
  #   countries text,
  #   countries_ids integer[],
  #   sectors text,
  #   sector_ids integer[],
  #   clusters text,
  #   cluster_ids integer[],
  #   donors_ids integer[],
  #   is_active boolean,
  #   site_id integer,
  #   created_at timestamp without time zone
  # ) WITH (OIDS=FALSE)"


  def self.csv_attributes
    %W{ Organization Project\ Title Project\ Description Project\ Activities
        Additional\ Information Estimated\ Start\ Date Estimated\ End\ Date
        Donor Budget Implementing\ Organization(s) Partner\ Organization(s)
        Cluster(s) Sector(s) Cross\ Cutting\ Issues Number\ of\ People\ Reached\ (target) Target\ Groups
        Country 1st\ Admin\ Level 2nd\ Admin\ Level 3rd\ Admin\ Level Contact\ Name Contact\ Title
        Contact\ Email Website Date\ Provided Date\ Updated }
  end

  def csv_columns(site_id = nil)
    raw_result = if site_id.nil?
      ActiveRecord::Base.connection.execute("select * from data_denormalization where project_id = #{self.id} LIMIT 1").first
    else
      ActiveRecord::Base.connection.execute("select * from data_denormalization where project_id = #{self.id} AND site_id = #{site_id}").first
    end
    return [] if raw_result.nil?
    columns = []
    columns << raw_result['organization_name']
    columns << raw_result['project_name']
    columns << raw_result['project_description']
    columns << self.activities
    columns << self.additional_information
    columns << if self.start_date.nil?
      ""
    else
      self.start_date.strftime("%Y-%m-%d")
    end
    columns << if self.end_date.nil?
      ""
    else
      self.end_date.strftime("%Y-%m-%d")
    end
    columns << self.donors.map{ |donor| donor.name }.join(',')
    columns << self.budget
    columns << self.implementing_organization
    columns << self.partner_organizations
    columns << if raw_result['clusters']
      raw_result['clusters'].text2array.join(',')
    else
      ""
    end
    columns << if raw_result['sectors']
      raw_result['sectors'].text2array.join(',')
    else
      ""
    end
    columns << self.cross_cutting_issues
    columns << self.estimated_people_reached
    columns << self.target
    columns << if raw_result['countries']
      raw_result['countries'].text2array.join(',')
    else
      ""
    end
    columns << regions.where(:level => 1).select(Region.custom_fields).map{ |r| r.name }.join(',')
    columns << regions.where(:level => 2).select(Region.custom_fields).map{ |r| r.name }.join(',')
    columns << regions.where(:level => 3).select(Region.custom_fields).map{ |r| r.name }.join(',')
    columns << self.contact_person
    columns << self.contact_position
    columns << self.contact_email
    columns << self.website
    columns << if self.date_provided.nil?
      ""
    else
      self.date_provided.strftime("%Y-%m-%d")
    end
    columns << if self.date_updated.nil?
      ""
    else
      self.date_updated.strftime("%Y-%m-%d")
    end
    columns
  end

  def to_csv(site_id)
    FasterCSV.generate(:col_sep => ';') do |csv|
      csv << self.class.csv_attributes
      csv << csv_columns(site_id)
    end
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
      and project_id!=#{self.id} and site_id=#{site.id} and is_active=true
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
          and project_id!=#{self.id} and site_id=#{site.id} and is_active=true
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
          project_id!=#{self.id} and site_id=#{site.id} and is_active=true
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
      sql="select * from data_denormalization where regions_ids && '{#{options[:region]}}' and site_id=#{site.id} and is_active=true"
    elsif options[:cluster]
      sql="select * from data_denormalization where cluster_ids && '{#{options[:cluster]}}' and site_id=#{site.id} and is_active=true"
    elsif options[:sector]
      sql="select * from data_denormalization where sector_ids && '{#{options[:sector]}}' and site_id=#{site.id} and is_active=true"
    elsif options[:organization]
      sql="select * from data_denormalization where organization_id = #{options[:organization]} and site_id=#{site.id} and is_active=true"
    elsif options[:donor_id]
      sql="select * from data_denormalization where donors_ids && '{#{options[:donor_id]}}' and site_id=#{site.id} and is_active=true"
    else
      sql="select * from data_denormalization where site_id=#{site.id} and is_active=true"
    end

    if options[:country]
      sql << " WHERE "
      conditions = []
      if options[:country]
        conditions << "countries_ids && '{#{options[:country]}}'"
      end
      sql << conditions.join(' and ')
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
      offset = if (options[:page].to_i + start_in_page - 1) <= total_pages
        options[:per_page].to_i * (options[:page].to_i + start_in_page - 1)
      else
        options[:per_page].to_i * (options[:page].to_i - start_in_page)
      end
      raise Iom::InvalidOffset if offset < 0
      sql << " OFFSET #{offset}"
    end
    result = ActiveRecord::Base.connection.execute(sql).map{ |r| r }
    WillPaginate::RandomCollection.create(options[:page] ? options[:page].to_i : 1, options[:per_page], total_entries, start_in_page) do |pager|
      pager.replace(result.sort_by{rand})
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
    self.country_ids = country_ids
    self.region_ids = region_ids
  end

  def set_cached_sites
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
      end
    end
  end

  def remove_cached_sites
    Site.all.each do |site|
      sql = "delete from projects_sites where project_id=#{self.id}"
      ActiveRecord::Base.connection.execute(sql)
      sql = "delete from data_denormalization where project_id=#{self.id}"
      ActiveRecord::Base.connection.execute(sql)
    end
  end

  private

    def dates_consistency
      return true if end_date.nil? || start_date.nil?
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
