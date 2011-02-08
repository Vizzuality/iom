# == Schema Information
#
# Table name: sites
#
#  id                              :integer         not null, primary key
#  name                            :string(255)
#  short_description               :text
#  long_description                :text
#  contact_email                   :string(255)
#  contact_person                  :string(255)
#  url                             :string(255)
#  permalink                       :string(255)
#  google_analytics_id             :string(255)
#  logo_file_name                  :string(255)
#  logo_content_type               :string(255)
#  logo_file_size                  :integer
#  logo_updated_at                 :datetime
#  theme_id                        :integer
#  blog_url                        :string(255)
#  word_for_clusters               :string(255)
#  word_for_regions                :string(255)
#  show_global_donations_raises    :boolean
#  project_classification          :integer         default(0)
#  geographic_context_country_id   :integer
#  geographic_context_region_id    :integer
#  project_context_cluster_id      :integer
#  project_context_sector_id       :integer
#  project_context_organization_id :integer
#  project_context_tags            :string(255)
#  created_at                      :datetime
#  updated_at                      :datetime
#  geographic_context_geometry     :string
#  project_context_tags_ids        :string(255)
#  status                          :boolean
#  visits                          :float           default(0.0)
#  visits_last_week                :float           default(0.0)
#  aid_map_image_file_name         :string(255)
#  aid_map_image_content_type      :string(255)
#  aid_map_image_file_size         :integer
#  aid_map_image_updated_at        :datetime
#  overview_map_bbox_miny          :float
#  overview_map_bbox_minx          :float
#  overview_map_bbox_maxy          :float
#  overview_map_bbox_maxx          :float
#  navigate_by_country             :boolean
#  navigate_by_level1              :boolean
#  navigate_by_level2              :boolean
#  navigate_by_level3              :boolean
#  map_styles                      :text
#


class Site < ActiveRecord::Base

  @@main_domain = 'ngoaidmap.org'

  has_many :resources, :conditions => 'resources.element_type = #{Iom::ActsAsResource::SITE_TYPE}', :foreign_key => :element_id, :dependent => :destroy
  has_many :media_resources, :conditions => 'media_resources.element_type = #{Iom::ActsAsResource::SITE_TYPE}', :foreign_key => :element_id, :dependent => :destroy, :order => 'position ASC'
  belongs_to  :theme
  belongs_to  :geographic_context_country, :class_name => 'Country'
  belongs_to :geographic_context_region, :class_name => 'Region'
  has_many :partners, :dependent => :destroy
  has_many :pages, :dependent => :destroy
  has_many :cached_projects, :class_name => 'Project', :finder_sql => 'select projects.* from projects, projects_sites where projects_sites.site_id = #{id} and projects_sites.project_id = projects.id'
  belongs_to :geographic_context_country, :class_name => 'Country'
  belongs_to :geographic_context_region, :class_name => 'Region'
  has_many :stats, :dependent => :destroy

  has_attached_file :logo, :styles => {
                                      :small => {
                                        :geometry => "80x46>",
                                        :format => 'jpg'
                                      }
                                    },
                            :url => "/system/:attachment/:id/:style.:extension"

  has_attached_file :aid_map_image, :styles => {
                                      :small => {
                                        :geometry => "203x115#",
                                        :format => 'jpg'
                                      },
                                      :huge => {
                                        :geometry => "927x524#",
                                        :format => 'jpg'
                                      }
                                    },
                                    :convert_options => {
                                      :all => "-quality 90"
                                    },
                                    :url => "/system/:attachment/:id/:style.:extension",
                                    :default_url => "/images/no_aid_map_image_huge.jpg"

  scope :published, where(:status => true)
  scope :draft,     where(:status => false)

  validates_presence_of   :name, :url
  validates_uniqueness_of :url

  before_validation :clean_html
  attr_accessor :geographic_context, :project_context, :show_blog, :geographic_boundary_box

  before_save :set_project_context, :set_project_context_tags_ids
  after_save :set_cached_projects
  after_create :create_pages
  after_destroy :remove_cached_projects

  def show_blog
    !blog_url.blank?
  end
  alias :show_blog? :show_blog

  def blog_url
    url = read_attribute(:blog_url)
    if url !~ /^http:\/\// && !url.blank?
      url = "http://#{url}"
    end
    url
  end

  def word_for_clusters
    w = read_attribute(:word_for_clusters)
    if w.blank?
      if navigate_by_cluster?
        'clusters'
      else
        'sectors'
      end
    else
      w
    end
  end

  alias :word_for_cluster_sector :word_for_clusters

  def word_for_regions
    w = read_attribute(:word_for_regions)
    w.blank? ? 'regions' : w
  end

  def cluster
    Cluster.find(self.project_context_cluster_id)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def published?
    status == true
  end

  def sector
    Sector.find(self.project_context_sector_id)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def navigate_by_cluster?
    project_classification == 0
  end

  def navigate_by_sector?
    project_classification == 1
  end

  # Filter projects from site configuration
  #
  # Use cases:
  #
  #  - cluster filtering (1)
  #    query: select projects.* from projects, clusters_projects where clusters_projects.project_id = projects.id and clusters_projects.cluster_id = #{cluster_id}
  #
  #  - sector filtering (2)
  #    query: select projects.* from projects, projects_sectors where projects_sectors.project_id = projects.id and projects_sectors.sector_id = #{sector_id}
  #
  #  - organizacion filtering (3)
  #    query: select projects.* from projects where projects.primary_organization_id = #{organization_id}
  #
  #  - tags filtering (4)
  #    query: select projects.* from projects, projects_tags where projects_tags.project_id = projects.id and projects_tags.id IN (#{tags_ids})
  #
  #  - country filtering (5)
  #    query: select projects.* from projects, countries_projects where countries_projects.project_id = projects.id and countries_projects.country_id = #{country_id}
  #
  #  - region filtering (6)
  #    query: select projects.* from projects, projects_regions where projects_regions.project_id = projects.id and projects_regions.region_id = #{region_id}
  #
  #  - bbox filtering (7)
  #    query : select projects.* from projects where ST_Contains(projects.the_geom, #{geographic_context_geometry})
  #
  def projects_sql(options = {})
    default_options = { :limit => 10, :offset => 0 }
    options = default_options.merge(options)

    select = "projects.*"
    from   = ["projects"]
    where  = []

    # (1)
    if project_context_cluster_id?
      from << "clusters_projects"
      where << "(clusters_projects.project_id = projects.id AND clusters_projects.cluster_id = #{project_context_cluster_id})"
    end

    # (2)
    if project_context_sector_id?
      from << "projects_sectors"
      where << "(projects_sectors.project_id = projects.id AND projects_sectors.sector_id = #{project_context_sector_id})"
    end

    # (3)
    if project_context_organization_id?
      where << "projects.primary_organization_id = #{project_context_organization_id}"
    end

    # (4)
    if project_context_tags_ids?
      from << "projects_tags"
      where << "(projects_tags.project_id = projects.id AND projects_tags.tag_id IN (#{project_context_tags_ids}))"
    end

    # (5)
    if geographic_context_country_id? && geographic_context_region_id.blank?
      # from << "countries_projects"
      # where << "(countries_projects.project_id = projects.id AND countries_projects.country_id = #{geographic_context_country_id})"
      # Instead on looking in the countries, we look in the regions of the level configured in the site
      # to get the valid projects
      from << "countries_projects"
      where << "(countries_projects.project_id = projects.id AND countries_projects.country_id=#{self.geographic_context_country_id})"
    end

    # (6)
    if geographic_context_region_id?
      from << "projects_regions"
      where << "(projects_regions.project_id = projects.id AND projects_regions.region_id = #{geographic_context_region_id})"
    end

    # (7)
    if geographic_context_geometry?
      from  << 'sites'
      where << "ST_Contains(sites.geographic_context_geometry,projects.the_geom)"
    end

    result = Project.select(select).from(from.join(',')).where(where.join(' AND ')).group(Project.custom_fields.join(','))

    if options[:limit]
      result = result.limit(options[:limit])
      if options[:offset]
        result = result.offset(options[:offset])
      end
    end
    result
  end

  # Return All the projects within the Site (already executed)
  def projects(options = {})
    projects_sql(options.merge(:limit => nil, :offset => nil)).all
  end

  def level_for_region
    if navigate_by_level1?
      1
    elsif navigate_by_level2?
      2
    elsif navigate_by_level3?
      3
    else
      0
    end
  end

  def levels_for_region
    levels = []
    levels << 1 if navigate_by_level1?
    levels << 2 if navigate_by_level2?
    levels << 3 if navigate_by_level3?
    levels
  end

  def projects_sectors_or_clusters
    if navigate_by_sector?
      categories = projects_sectors
    elsif navigate_by_cluster?
      categories = projects_clusters
    end

    categories.sort!{|x, y| x.first.class.name <=> y.first.class.name}
    categories
  end

  def projects_ids_string
    # projects_ids seems to return a -1 id. #BUG?
    # no, feature!
    # this way never is empty => Nice! Thanks for clarification
    (self.projects_ids - [-1]).join(',')
  end

  # Array of arrays
  # [[cluster, count], [cluster, count]]
  def projects_clusters
    sql="select c.id,c.name,count(ps.*) as count from clusters as c
    inner join clusters_projects as cp on c.id=cp.cluster_id
    inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=#{self.id}
    inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
    group by c.id,c.name order by count desc limit 20"
    Cluster.find_by_sql(sql).map do |c|
      [c,c.count.to_i]
    end
  end

  # Array of arrays
  # [[sector, count], [sector, count]]
  def projects_sectors
    sql="select s.id,s.name,count(ps.*) as count from sectors as s
    inner join projects_sectors as cp on s.id=cp.sector_id
    inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=#{self.id}
    inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
    group by s.id,s.name order by count DESC limit 20"
    Sector.find_by_sql(sql).map do |s|
      [s,s.count.to_i]
    end
  end

  # Array of arrays
  # [[region, count], [region, count]]
  def projects_regions
    sql="select #{Region.custom_fields.join(',')},count(ps.*) as count from regions
      inner join projects_regions as pr on regions.id=pr.region_id and regions.level=#{self.level_for_region}
      inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{self.id}
      inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
      group by #{Region.custom_fields.join(',')} order by count DESC"
    Region.find_by_sql(sql).map do |r|
      [r,r.count.to_i]
    end
  end

  def total_regions
    sql="select count(distinct(regions.id)) as count from regions
      inner join projects_regions as pr on pr.region_id=regions.id and regions.level=#{self.level_for_region}
      inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{self.id}
      inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now());"
    ActiveRecord::Base.connection.execute(sql).first['count'].to_i
  end

  def total_countries
    sql="select count(distinct(countries.id)) as count from countries
      inner join countries_projects as pr on pr.country_id=countries.id
      inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{self.id}
      inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now());"
    ActiveRecord::Base.connection.execute(sql).first['count'].to_i
  end

  # Array of arrays
  # [[country, count], [country, count]]
  def projects_countries
    sql="select #{Country.custom_fields.join(',')},count(ps.*) as count from countries
      inner join regions on regions.country_id = countries.id and regions.level=#{self.level_for_region}
      inner join projects_regions as pr on regions.id=pr.region_id
      inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{self.id}
      inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
      group by #{Country.custom_fields.join(',')} order by count DESC"
    Country.find_by_sql(sql).map do |c|
      [c,c.count.to_i]
    end
  end
  # Array of arrays
  # [[organization, count], [organization, count]]
  def projects_organizations
    sql="select o.id,o.name,count(ps.*) as count from organizations as o
      inner join projects as p on o.id=p.primary_organization_id
      inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{self.id}
      inner join projects as pr on ps.project_id=pr.id and (pr.end_date is null OR pr.end_date > now())
      group by o.id,o.name order by count DESC"
    Organization.find_by_sql(sql).map do |o|
        [o,o.count.to_i]
    end
  end

  #Tells me if a project is included in a site or not
  def is_project_included?(project_id)
    projects.map(&:id).include?(project_id)
  end

  def total_projects(options = {})
    sql = "select count(projects_sites.project_id) as count from projects_sites, projects where projects_sites.site_id = #{self.id}
                  and projects_sites.project_id = projects.id and (projects.end_date is null OR projects.end_date > now())"
    ActiveRecord::Base.connection.execute(sql).first['count'].to_i
  end

  def projects_ids
    sql = "select projects_sites.project_id as project_id from projects_sites where projects_sites.site_id = #{self.id}"
    ActiveRecord::Base.connection.execute(sql).map{ |r| r['project_id'] }
  end

  def donors
    Donor.find_by_sql("select d.* from donors as d where id in (
    select don.donor_id from (donations as don inner join projects as p on don.project_id=p.id) inner join projects_sites as ps on p.id=ps.project_id and site_id=#{self.id})")
  end

  def organizations
    Organization.find_by_sql("select o.* from organizations as o where id in (
    select p.primary_organization_id from projects as p inner join projects_sites as ps on p.id=ps.project_id and site_id=#{self.id}) order by o.name")
  end

  def organizations_count
    sql = "select count(o.id) as count from organizations as o where id in (
    select p.primary_organization_id from projects as p inner join projects_sites as ps on p.id=ps.project_id and site_id=#{self.id})"
    ActiveRecord::Base.connection.execute(sql).first['count'].to_i
  end

  def clusters
    Cluster.find_by_sql("select c.* from clusters as c where id in (
        select cp.cluster_id from (clusters_projects as cp inner join projects as p on cp.project_id=p.id)
        inner join projects_sites as ps on p.id=ps.project_id and site_id=#{self.id})
        order by c.name")
  end

  def sectors
    Sector.find_by_sql("select s.* from sectors as s where id in (
        select pse.project_id from (projects_sectors as pse inner join projects as p on pse.project_id=p.id)
        inner join projects_sites as ps on p.id=ps.project_id and site_id=#{self.id})
        order by s.name")
  end

  def clusters_or_sectors
    if self.navigate_by_cluster?
      self.clusters
    elsif self.navigate_by_sector?
      self.sectors
    end
  end

  def geographic_context_region_id=(value)
    value = nil if value.to_i == 0
    write_attribute(:geographic_context_region_id, value)
  end

  def set_yesterday_visits!
    return if self.google_analytics_id.blank? || Settings.first.data[:google_analytics_username].blank? || Settings.first.data[:google_analytics_password].blank?
    Garb::Session.login(Settings.first.data[:google_analytics_username], Settings.first.data[:google_analytics_password])
    profile = Garb::Profile.all.detect{|p| p.web_property_id == self.google_analytics_id}
    report = Garb::Report.new(profile, :start_date => (Date.today - 1.day).beginning_of_day, :end_date => (Date.today - 1.day).end_of_day)
    report.metrics :visits
    result = report.results.first
    stats.create(:visits => result.visits.to_i, :date => Date.yesterday)
  end

  def set_visits!
    return if self.google_analytics_id.blank? || Settings.first.data[:google_analytics_username].blank? || Settings.first.data[:google_analytics_password].blank?
    Garb::Session.login(Settings.first.data[:google_analytics_username], Settings.first.data[:google_analytics_password])
    profile = Garb::Profile.all.detect{|p| p.web_property_id == self.google_analytics_id}
    report = Garb::Report.new(profile)
    report.metrics :visits
    result = report.results.first
    update_attribute(:visits, result.visits.to_i)
  end

  def set_visits_from_last_week!
    return if self.google_analytics_id.blank? || Settings.first.data[:google_analytics_username].blank? || Settings.first.data[:google_analytics_password].blank?
    Garb::Session.login(Settings.first.data[:google_analytics_username], Settings.first.data[:google_analytics_password])
    profile = Garb::Profile.all.detect{|p| p.web_property_id == self.google_analytics_id}
    report = Garb::Report.new(profile, :start_date => (Date.today - 7.days), :end_date => Date.today)
    report.metrics :visits
    report.dimensions :date
    result = report.results.first
    update_attribute(:visits_last_week, result.visits.to_i)
  end

  def geographic_boundary_box
    self.geographic_context_geometry.rings.collect{|line_string| line_string.text_representation }.join("|") if self.geographic_context_geometry
  end

  def geographic_boundary_box=(geometry)
    return if geometry.blank?
    coords         = geometry.split(',').map{|c| c.split(' ')}
    polygon_points = []

    coords.each {|c| polygon_points << Point.from_x_y(c.first.to_f, c.last.to_f)}

    self.geographic_context_geometry = Polygon.from_points([polygon_points])
  end

  def subdomain=(subdomain)
    self.url = "#{subdomain}.#{@@main_domain}" if subdomain.present?
  end

  def subdomain
    url.split('.').first unless url.blank?
  end

  def last_visits(limit = 30)
    stats.order("date ASC").limit(limit).map{ |s| s.visits }.join(',')
  end

  def countries_select
    if geographic_context_country_id.blank? && geographic_context_region_id.blank?
      # Country.get_select_values
      Country.find_by_sql(<<-SQL
        select id,name from countries
        where id in (select country_id
        from countries_projects as cr inner join projects_sites as ps
        on cr.project_id=ps.project_id and site_id=#{self.id}) order by name
SQL
      )
    else
      if geographic_context_region_id.blank?
        [Country.find(self.geographic_context_country_id, :select => Country.custom_fields)]
      else
        nil
      end
    end
  end

  def world_wide_context?
    geographic_context_country_id.nil? && geographic_context_region_id.nil?
  end

  def countries
    if geographic_context_country_id.blank? && geographic_context_region_id.blank?
      Country.find_by_sql(<<-SQL
        select id,name from countries
        where id in (select country_id
        from countries_projects as cr inner join projects_sites as ps
        on cr.project_id=ps.project_id and site_id=#{self.id}) order by name
SQL
      )
    else
      if geographic_context_region_id.blank?
        Country.find(self.geographic_context_country_id, :select => Country.custom_fields)
      else
        nil
      end
    end
  end

  def regions_select
    if geographic_context_country_id.blank? && geographic_context_region_id.blank?
      []
    else
      Region.find_by_sql(<<-SQL
        select id,name,path from regions
        where level=#{level_for_region}
        and id in (select region_id from projects_regions as pr
        inner join projects_sites as ps on pr.project_id=ps.project_id and site_id=#{self.id})
        order by name
SQL
      )
    end
  end

  def organizations_select
    Organization.find_by_sql(<<-SQL
        select distinct o.id,o.name from organizations as o
        inner join projects as p on p.primary_organization_id=o.id
        inner join projects_sites as ps on p.id=ps.project_id and site_id=#{self.id}
        order by o.name
SQL
    )
  end

  def regions
    if geographic_context_country_id.blank? && geographic_context_region_id.blank?
      []
    else
      Region.where(:country_id => geographic_context_country_id, :level => level_for_region).select(Region.custom_fields)
    end
  end

  def navigate_by_regions?
    navigate_by_level1? || navigate_by_level2 || navigate_by_level3
  end

  def navigate_by
    if navigate_by_country?
      :country
    else
      if navigate_by_level1?
        :level1
      elsif navigate_by_level2?
        :level2
      elsif navigate_by_level3?
        :level3
      end
    end
  end

  def set_cached_projects
    remove_cached_projects

    #Insert into the relation all the sites that belong to the site.
    sql="insert into projects_sites
    select subsql.id as project_id, #{self.id} as site_id from (#{projects_sql({ :limit => nil, :offset => nil }).to_sql}) as subsql"
    ActiveRecord::Base.connection.execute(sql)
    #Work on the denormalization

    sql="insert into data_denormalization(project_id,project_name,project_description,organization_id,organization_name,end_date,regions,regions_ids,countries,countries_ids,sectors,sector_ids,clusters,cluster_ids,donors_ids,is_active,site_id,created_at)
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
           LEFT JOIN regions as r ON pr.region_id=r.id and r.level=#{self.level_for_region}
           LEFT JOIN countries_projects as cp ON cp.project_id=p.id
           LEFT JOIN countries as c ON c.id=cp.country_id
           LEFT JOIN clusters_projects as cpro ON cpro.project_id=p.id
           LEFT JOIN clusters as clus ON clus.id=cpro.cluster_id
           LEFT JOIN projects_sectors as psec ON psec.project_id=p.id
           LEFT JOIN sectors as sec ON sec.id=psec.sector_id
           LEFT JOIN donations as d ON d.project_id=ps.project_id
           where site_id=#{self.id}
           GROUP BY p.id,p.name,o.id,o.name,p.description,p.end_date,ps.site_id,p.created_at) as subq"
     ActiveRecord::Base.connection.execute(sql)
  end

  def remove_cached_projects
    ActiveRecord::Base.connection.execute("DELETE FROM projects_sites WHERE site_id = #{self.id}")
    ActiveRecord::Base.connection.execute("DELETE FROM data_denormalization WHERE site_id = #{self.id}")
  end

  private

    def clean_html
      %W{ name short_description long_description contact_person contact_email url permalink }.each do |att|
        eval("self.#{att} = Sanitize.clean(self.#{att}.gsub(/\r/,'')) unless self.#{att}.blank?")
      end
    end

    def set_project_context
      return if project_context.blank?
      unless project_context.include?('tags')
        self.project_context_tags = nil
      end
      unless project_context.include?('cluster')
        self.project_context_cluster_id = nil
      end
      unless project_context.include?('organization')
        self.project_context_organization_id = nil
      end
    end

    # Get project tags names and sets the id's from that tags
    def set_project_context_tags_ids
      return if project_context_tags.blank?
      tag_names = project_context_tags.split(',').map{ |t| t.strip }.compact.delete_if{ |t| t.blank? }
      self.project_context_tags_ids = tag_names.map{ |tag_name| Tag.find_by_name(tag_name).try(:id) }.compact.join(',')
    end

    def create_pages
      about = self.pages.create :title => 'About'
      self.pages.create :title => 'Contact', :parent_id => about.id
      self.pages.create :title => 'Highlights', :parent_id => about.id
    end

end
