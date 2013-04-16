# == Schema Information
#
# Table name: regions
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  level            :integer
#  country_id       :integer
#  parent_region_id :integer
#  center_lat       :float
#  center_lon       :float
#  path             :string(255)
#  the_geom         :string
#  gadm_id          :integer
#  wiki_url         :string(255)
#  wiki_description :text
#  code             :string(255)
#  the_geom_geojson :text
#  ia_name          :text
#

class Region < ActiveRecord::Base

  belongs_to :country
  belongs_to :region, :foreign_key => :parent_region_id, :class_name => 'Region'

  has_and_belongs_to_many :projects

  before_save :update_wikipedia_description

  after_save :set_path

  def self.custom_fields
    (columns.map{ |c| c.name } - ['the_geom']).map{ |c| "#{self.table_name}.#{c}" }
  end

  # Array of arrays
  # [[cluster, count], [cluster, count]]
  def projects_clusters_sectors(site)
    if site.navigate_by_cluster?
      sql="select c.id,c.name,count(c.id) as count from clusters_projects as cp
          inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=#{site.id}
          inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
          inner join clusters as c on cp.cluster_id=c.id
          inner join projects_regions as pr on ps.project_id=pr.project_id and region_id=#{self.id}
          group by c.id,c.name order by count DESC"
      Cluster.find_by_sql(sql).map do |c|
          [c,c.count.to_i]
      end
    else
      sql="select s.id,s.name,count(s.id) as count from projects_sectors as pjs
          inner join projects_sites as ps on pjs.project_id=ps.project_id and ps.site_id=#{site.id}
          inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
          inner join sectors as s on pjs.sector_id=s.id
          inner join projects_regions as pr on ps.project_id=pr.project_id and region_id=#{self.id}
          group by s.id,s.name order by count DESC"
      Sector.find_by_sql(sql).map do |s|
          [s,s.count.to_i]
      end
    end
  end

  # Array of arrays
  # [[organization, count], [organization, count]]
  def projects_organizations(site)
    sql="select o.id,o.name,count(o.id) as count from projects_sites as ps
    inner join projects as p on ps.project_id=p.id and ps.site_id=#{site.id} and (p.end_date is null OR p.end_date > now())
    inner join organizations as o on p.primary_organization_id=o.id
    inner join projects_regions as pr on ps.project_id=pr.project_id and region_id=#{self.id}
    group by o.id,o.name order by count DESC"
    Organization.find_by_sql(sql).map do |o|
        [o,o.count.to_i]
    end
  end

  def donors_count(site)
    ActiveRecord::Base.connection.execute(<<-SQL
      select count(*) from (
        select distinct don.* from projects_sites as ps
        inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
        inner join donations as d on ps.project_id=d.project_id and ps.site_id=#{site.id}
        inner join donors as don on don.id=d.donor_id
        inner join projects_regions as pr on ps.project_id=pr.project_id and region_id=#{self.id}
      ) as count
    SQL
    ).first['count'].to_i
  end

  def donors(site, limit = nil)
    limit = ''
    limit = "LIMIT #{limit}" if limit.present?

    sql="select distinct don.* from projects_sites as ps
    inner join donations as d on ps.project_id=d.project_id and ps.site_id=#{site.id}
    inner join projects as p on d.project_id = p.id and (p.end_date is null OR p.end_date > now())
    inner join donors as don on don.id=d.donor_id
    inner join projects_regions as pr on ps.project_id=pr.project_id and region_id=#{self.id}
    #{limit}"

    Donor.find_by_sql(sql)
  end

  def donors_budget(site)
    amount = 0
    donors(site).each { |donor| amount += donor.donations_amount }
    return amount
  end

  def self.get_select_values
    scoped.select("id,name,level,parent_region_id,country_id").order("name ASC")
  end

  def update_wikipedia_description
    if wiki_url.present?
      require 'open-uri'
      doc = Nokogiri::HTML(open(URI.encode(wiki_url), 'User-Agent' => 'NgoAidMap.net'))

      #SUCK OUT ALL THE PARAGRAPHS INTO AN ARRAY
      #CLEANING UP TEXT REMOVING THE '[\d+]'s
      paragraphs = doc.css('#bodyContent p').inject([]) {|a,p|
        a << p.content.gsub(/\[\d+\]/,"")
        a
      }

      self.wiki_description = paragraphs.first if paragraphs.present?
    end
  end
  private :update_wikipedia_description

  def near(site, limit = 5)
    unless site.navigate_by_country?
      Region.find_by_sql(<<-SQL
        select * from
        (select re.id, re.name, re.level, re.country_id, re.parent_region_id, re.path,
             ST_Distance((select ST_Centroid(the_geom) from regions where id=#{self.id}), ST_Centroid(the_geom)) as dist,
             (
              select count(*) from projects_regions as pr
              inner join projects as p on p.id=pr.project_id and (p.end_date is null OR p.end_date > now())
              where region_id=re.id
            ) as count
             from regions as re
             where id!=#{self.id} and
             level=#{site.level_for_region}
             order by dist
        ) as subq
        where count>0
        order by dist, count DESC
        limit  #{limit}
SQL
      )
    else
      Region.find_by_sql(<<-SQL
        select * from
        (select re.id, re.name, re.level, re.country_id, re.parent_region_id, re.path,
             ST_Distance((select ST_Centroid(the_geom) from regions where id=#{self.id}), ST_Centroid(the_geom)) as dist,
             (select count(*) from projects_regions as pr
              inner join projects as p on p.id=pr.project_id and (p.end_date is null OR p.end_date > now())
               where region_id=re.id) as count
             from regions as re
             where id!=#{self.id} and
             re.level=#{self.level} and
             re.country_id = #{self.country_id}
             order by dist
        ) as subq
        where count>0
        order by count DESC
        limit  #{limit}
SQL
      )
    end
  end

  def projects_count(site, category_id = nil)
    if category_id.present?
      if site.navigate_by_cluster?
        category_join = "inner join clusters_projects as cp on cp.project_id = p.id and cp.cluster_id = #{category_id}"
      else
        category_join = "inner join projects_sectors as pse on pse.project_id = p.id and pse.sector_id = #{category_id}"
      end
    end

    sql = "select count(distinct(pr.project_id)) as count from projects_regions as pr
    inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{site.id}
    inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
    #{category_join}
    where pr.region_id=#{self.id}"
    ActiveRecord::Base.connection.execute(sql).first['count'].to_i
  end

  def projects_for_csv(site)
    sql = "select p.id, p.name, p.description, p.primary_organization_id, p.implementing_organization, p.partner_organizations, p.cross_cutting_issues, p.start_date, p.end_date, p.budget, p.target, p.estimated_people_reached, p.contact_person, p.contact_email, p.contact_phone_number, p.site_specific_information, p.created_at, p.updated_at, p.activities, p.intervention_id, p.additional_information, p.awardee_type, p.date_provided, p.date_updated, p.contact_position, p.website, p.verbatim_location, p.calculation_of_number_of_people_reached, p.project_needs, p.idprefugee_camp
    from projects_regions as pr
    inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{site.id}
    inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
    where pr.region_id=#{self.id}"
    ActiveRecord::Base.connection.execute(sql)
  end

  def projects_for_kml(site)
    sql = "select p.name, ST_AsKML(p.the_geom) as the_geom
    from projects_regions as pr
    inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{site.id}
    inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
    where pr.region_id=#{self.id}"
    ActiveRecord::Base.connection.execute(sql)
  end

  def to_param
    self.path
  end

  private

    def set_path
      sql = case level
        when 1
          unless self.country_id.blank?
            "update regions set path=#{self.country_id} || '/' || #{self.id} where id=#{self.id}"
          else
            nil
          end
        when 2
          unless self.country_id.blank? || self.parent_region_id.blank?
            "update regions set path=#{self.country_id} || '/' || #{self.parent_region_id} || '/' || #{self.id} where id=#{self.id}"
          else
            nil
          end
        when 3
          "update regions as ur set path=(
          SELECT (((((( r3.country_id) || '/'::text) || r2.parent_region_id) || '/'::text) || r2.id) || '/'::text) || r3.id AS url
          FROM regions r3
          JOIN regions r2 ON r3.parent_region_id = r2.id
          WHERE r3.id=#{self.id})"
      end
      unless sql.blank?
        ActiveRecord::Base.connection.execute(sql)
        reload
      end
    end

end
