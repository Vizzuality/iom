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
#  date_provided             :date
#  date_updated              :date
#  contact_position          :string(255)
#  website                   :string(255)
#  the_geom                  :string          not null
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

  attr_accessor :sectors_ids, :clusters_ids

   def before_save
     self.the_geom ||= MultiPoint.from_points([Point.from_x_y(0, -77)])
   end

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

  def to_csv(site_id)
    sql = <<-SQL
      SELECT *
      FROM v_projects_denormalized
      WHERE id = #{self.id}
    SQL

    result = ActiveRecord::Base.connection.execute(sql)
    result.serialize_to_csv
  end

  def related(site, limit = 2)
    return [] unless the_geom?
    Project.find_by_sql(<<-SQL
      select * from
      (select p.id, p.name, p.primary_organization_id, o.name as primary_organization_name, c.name as country_name,
           ST_Distance((select ST_Centroid(p.the_geom) from projects where id=#{self.id}), ST_Centroid(p.the_geom)) as dist
           from organizations o, projects as p
           inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{site.id}
           inner join countries_projects as cp on ps.project_id=cp.project_id
           inner join countries as c on cp.country_id=c.id
           where p.id!=#{self.id} and o.id=p.primary_organization_id
           order by dist
      ) as subq
      limit  #{limit}
SQL
    )
  end

  def self.custom_find(site, options = {})
    # options: :per_page => 10, :page => params[:page], :order => 'created_at DESC'
    sql = <<-SQL
    select * from
    (SELECT p.id as project_id, p.name as project_name, p.description as project_description, p.created_at, o.id as organization_id, o.name as organization_name,
    array_to_string(array_agg(distinct r.name),'|') as regions,
    array_to_string(array_agg(distinct r.id),'|') as region_ids,
    array_to_string(array_agg(distinct c.name),'|') as countries,
    array_to_string(array_agg(distinct c.id),'|') as countries_ids,
    array_to_string(array_agg(distinct sec.name),'|') as sectors,
    array_to_string(array_agg(distinct sec.id),'|') as sector_ids,
    array_to_string(array_agg(distinct clus.name),'|') as clusters,
    array_to_string(array_agg(distinct clus.id),'|') as cluster_ids

    FROM projects as p
    INNER JOIN organizations as o       ON p.primary_organization_id=o.id
    INNER JOIN projects_sites as ps     ON p.id=ps.project_id and ps.site_id=#{site.id}
    INNER JOIN projects_regions as pr   ON pr.project_id=p.id
    INNER JOIN regions as r             ON pr.region_id=r.id and r.level=#{site.level_for_region}
    INNER JOIN countries_projects as cp ON cp.project_id=p.id
    INNER JOIN countries as c           ON c.id=cp.country_id
    LEFT JOIN projects_sectors as psec  ON psec.project_id=p.id
    LEFT JOIN sectors as sec             ON sec.id=psec.sector_id
    LEFT JOIN clusters_projects as cpro ON cpro.project_id=p.id
    LEFT JOIN clusters as clus           ON clus.id=cpro.cluster_id
    GROUP BY p.id,p.name,o.id,o.name,c.name,p.created_at,p.description) as subq
SQL
    if options[:sector] || options[:cluster] || options[:donor_id] || options[:region] || options[:country] || options[:organization]
      sql << " WHERE "
      conditions = []
      if options[:sector]
        conditions << "sectors like '%#{options[:sector].sanitize_sql!}%'"
      end
      if options[:cluster]
        conditions << "clusters like '%#{options[:cluster].sanitize_sql!}%'"
      end
      if options[:donor_id]
        conditions << "project_id IN (SELECT project_id from donations WHERE donor_id=#{options[:donor_id]})"
      end
      if options[:region]
        conditions << "regions like '%#{options[:region].sanitize_sql!}%'"
      end
      if options[:country]
        conditions << "countries like '%#{options[:country].sanitize_sql!}%'"
      end
      if options[:organization]
        conditions << "organization_id=#{options[:organization]}"
      end
      sql << conditions.join(' and ')
    end
    if options[:order]
      sql << " ORDER BY #{options[:order]}"
    end
    # Let's query an extra result: if it exists, whe have to show the paginator link "More projects"
    if options[:per_page]
      sql << " LIMIT #{options[:per_page].to_i + 1}"
    end
    if options[:page] && options[:per_page]
      sql << " OFFSET #{options[:per_page].to_i * (options[:page].to_i - 1)}"
    end
    result = ActiveRecord::Base.connection.execute(sql).map{ |r| r }
    total_results = if options[:page].to_i < 2
      result.size + (options[:per_page].to_i * options[:page].to_i)
    else
      result.size + (options[:per_page].to_i * (options[:page].to_i - 1))
    end
    WillPaginate::Collection.create(options[:page] ? options[:page].to_i : 1, options[:per_page], total_results) do |pager|
      result = result[0..-2] if result.size > options[:per_page].to_i
      pager.replace(result)
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
