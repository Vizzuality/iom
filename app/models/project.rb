# == Schema Information
#
# Table name: projects
#
#  id                        :integer         not null, primary key
#  name                      :string(2000)
#  description               :text
#  primary_organization_id   :integer
#  implementing_organization :text
#  partner_organizations     :text
#  cross_cutting_issues      :text
#  start_date                :date
#  end_date                  :date
#  budget                    :integer
#  target                    :text
#  estimated_people_reached  :integer
#  contact_person            :string(255)
#  contact_email             :string(255)
#  contact_phone_number      :string(255)
#  site_specific_information :text
#  created_at                :datetime
#  updated_at                :datetime
#  activities                :text
#  intervention_id           :string(255)
#  additional_information    :text
#  awardee_type              :string(255)
#  the_geom                  :string          not null
#  date_provided             :date
#  date_updated              :date
#  contact_position          :string(255)
#  website                   :string(255)
#

class Project < ActiveRecord::Base

  # acts_as_geom :the_geom => :multi_point

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

  before_validation :clean_html

  validates_presence_of :primary_organization_id

  # validate :dates_consistency, :presence_of_clusters_and_sectors

  validate :dates_consistency

  after_save :set_cached_sites
  after_destroy :remove_cached_sites

  attr_accessor :sectors_ids, :clusters_ids

  def sectors_ids=(value)
    value.each do |sector_id|
      if sector = Sector.find(sector_id)
        sectors << sector unless sectors.include?(sector)
      end
    end
  end

  def clusters_ids=(value)
    value.each do |cluster_id|
      if cluster = Cluster.find(cluster_id)
        clusters << cluster unless clusters.include?(cluster)
      end
    end
  end

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

  def update_tag_counter(tag)
    tag.update_tag_counter
  end

  # TODO: remove this when reverse geocoding
  #  - reverse geocoding
  def before_save
    self.the_geom = MultiPoint.from_points([Point.from_x_y(0, -77)])
  end

  def finished?
    if (!end_date.nil?)
      end_date < Date.today
    else
      false
    end
  end

  def months_left
    unless finished?
      (end_date - Date.today).to_i / 30
    end
  end

  def to_kml
    the_geom.as_kml if the_geom.present?
  end

  private

    def clean_html
      %W{ name description implementing_organization partner_organizations cross_cutting_issues target contact_person contact_email contact_phone_number }.each do |att|
        eval("self.#{att} = Sanitize.clean(self.#{att}.gsub(/\r/,'')) unless self.#{att}.blank?")
      end
    end

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
      
      #TODO: Check whay this is slow.
      #countries << region.country unless countries.include?(region.country)

      # sql="SELECT count(*) as num from countries_projects where country_id=#{region.country.id} and project_id=#{id}"
      # if (ActiveRecord::Base.connection.execute(sql).first["num"].to_i < 1)
      #   countries << region.country
      # end      
      
    end

    def remove_from_country(region)
      countries.delete(region.country)
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

    def set_cached_sites
      sql="DELETE FROM projects_sites WHERE project_id=#{self.id}"
      ActiveRecord::Base.connection.execute(sql)
      Site.all.each do |site|        
        if site.is_project_included?(self.id)
          ActiveRecord::Base.connection.execute("INSERT INTO projects_sites (project_id, site_id) VALUES (#{self.id},#{site.id})")
        end
      end
    end

    def remove_cached_sites
      ActiveRecord::Base.connection.execute("DELETE FROM projects_sites WHERE project_id = '#{self.id}'")
    end

end
