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
#  project_context_tags_ids        :string(255)
#  status                          :boolean
#  visits                          :float           default(0.0)
#  visits_last_week                :float           default(0.0)
#  geographic_context_geometry     :string
#

class Site < ActiveRecord::Base

  #acts_as_geom :the_geom => :polygon

  has_many :resources, :conditions => 'resources.element_type = #{Iom::ActsAsResource::SITE_TYPE}', :foreign_key => :element_id, :dependent => :destroy
  has_many :media_resources, :conditions => 'media_resources.element_type = #{Iom::ActsAsResource::SITE_TYPE}', :foreign_key => :element_id, :dependent => :destroy, :order => 'position ASC'
  belongs_to  :theme
  has_many :partners, :dependent => :destroy
  has_many :pages, :dependent => :destroy

  has_attached_file :logo, :styles => { :small => "60x60#" }

  scope :published, where(:status => true)
  scope :draft,     where(:status => false)

  validates_presence_of :name, :url
  validates_uniqueness_of :url

  before_validation :clean_html

  attr_accessor :geographic_context, :project_context, :show_blog, :geographic_boundary_box

  before_save :set_geographic_context, :set_project_context, :set_project_context_tags_ids
  after_create :create_pages

  def show_blog
    !blog_url.blank?
  end
  alias :show_blog? :show_blog

  def word_for_clusters
    w = read_attribute(:word_for_clusters)
    w.blank? ? 'clusters' : w
  end

  def word_for_sectors
    w = read_attribute(:word_for_sectors)
    w.blank? ? 'sectors' : w
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
  def projects(options = {})
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
    if geographic_context_country_id?
      from << "countries_projects"
      where << "(countries_projects.project_id = projects.id AND countries_projects.country_id = #{geographic_context_country_id})"
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

    result = Project.select(select).from(from.join(',')).where(where.join(' AND '))

    if options[:limit]
      result = result.limit(options[:limit])
      if options[:offset]
        result = result.offset(options[:offset])
      end
    end
    result.all
  end

  # TODO: perform query with a count()
  def total_projects(options = {})
    projects(options).size
  end

  # TODO: performance, don't get all fields
  def projects_ids
    projects.map{ |p| p.id } + [-1]
  end

  def donors
    Donor.find_by_sql("select donors.* from donors, donations where donations.project_id IN (#{projects_ids.join(',')}) AND donations.donor_id = donors.id")
  end

  def organizations
    Organization.find_by_sql("select organizations.* from organizations, projects where projects.id IN (#{projects_ids.join(',')}) AND projects.primary_organization_id = organizations.id").uniq
  end

  def clusters
    Cluster.find_by_sql("select clusters.* from clusters, clusters_projects where clusters_projects.project_id in (#{projects_ids.join(',')}) AND clusters.id = clusters_projects.cluster_id").uniq
  end

  def sectors
    Sector.find_by_sql("select sectors.* from sectors, projects_sectors where projects_sectors.project_id in (#{projects_ids.join(',')}) AND sectors.id = projects_sectors.sector_id").uniq
  end

  def set_visits!
    return if self.google_analytics_id.blank? || Settings.first.google_analytics_username.blank? || Settings.first.google_analytics_password.blank?
    Garb::Session.login(Settings.first.google_analytics_username, Settings.first.google_analytics_password)
    profile = Garb::Profile.all.detect{|p| p.web_property_id == self.google_analytics_id}
    report = Garb::Report.new(profile)
    report.metrics :pageviews
    result = report.results.first
    update_attribute(:visits, result.pageviews.to_i)
  end

  def set_visits_from_last_week!
    return if self.google_analytics_id.blank? || Settings.first.google_analytics_username.blank? || Settings.first.google_analytics_password.blank?
    Garb::Session.login(Settings.first.google_analytics_username, Settings.first.google_analytics_password)
    profile = Garb::Profile.all.detect{|p| p.web_property_id == self.google_analytics_id}
    report = Garb::Report.new(profile, :start_date => (Date.today - 7.days), :end_date => Date.today)
    report.metrics :pageviews
    report.dimensions :date
    result = report.results.first
    update_attribute(:visits_last_week, result.pageviews.to_i)
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

  private

    def clean_html
      %W{ name short_description long_description contact_person contact_email url permalink }.each do |att|
        eval("self.#{att} = Sanitize.clean(self.#{att}.gsub(/\r/,'')) unless self.#{att}.blank?")
      end
    end

    def set_geographic_context
      unless geographic_context.blank?
        case geographic_context
        when 'worlwide'
          self.geographic_context_country_id = nil
          self.geographic_context_region_id  = nil
          self.geographic_context_geometry   = nil
        when 'country'
          self.geographic_context_region_id  = nil
          self.geographic_context_geometry   = nil
        when 'region'
          self.geographic_context_country_id = nil
          self.geographic_context_geometry   = nil
        when 'bbox'
          self.geographic_context_geometry   = nil
        end
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
      self.pages.create :title => 'About'
      self.pages.create :title => 'Contact'
      self.pages.create :title => 'Analysis'
    end

end
