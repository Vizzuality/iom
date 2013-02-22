# == Schema Information
#
# Table name: countries
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  code             :string(255)
#  center_lat       :float
#  center_lon       :float
#  the_geom         :string
#  wiki_url         :string(255)
#  wiki_description :text
#  iso2_code        :string(255)
#  iso3_code        :string(255)
#  the_geom_geojson :text
#

class Country < ActiveRecord::Base

  has_many :regions
  has_and_belongs_to_many :projects

  before_save :update_wikipedia_description

  def self.custom_fields
    (columns.map{ |c| c.name } - ['the_geom']).map{ |c| "#{self.table_name}.#{c}" }
  end

  # Array of arrays
  # [[cluster, count], [cluster, count]]
  def projects_clusters_sectors(site)
    if site.navigate_by_cluster?
      sql="select c.id,c.name,count(ps.*) as count from clusters as c
      inner join clusters_projects as cp on c.id=cp.cluster_id
      inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=#{site.id}
      inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
      inner join countries_projects as cop on ps.project_id=cop.project_id and cop.country_id=#{self.id}
      group by c.id,c.name order by count DESC"
      Cluster.find_by_sql(sql).map do |c|
        [c,c.count.to_i]
      end
    else
      sql="select s.id,s.name,count(ps.*) as count from sectors as s
      inner join projects_sectors as pjs on s.id=pjs.sector_id
      inner join projects_sites as ps on pjs.project_id=ps.project_id and ps.site_id=#{site.id}
      inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
      inner join countries_projects as cop on ps.project_id=cop.project_id and cop.country_id=#{self.id}
      group by s.id,s.name order by count DESC"
      Sector.find_by_sql(sql).map do |s|
        [s,s.count.to_i]
      end
    end
  end

  # Array of arrays
  # [[region, count], [region, count]]
  def regions_projects(site)
    sql="select r.id,r.name,count(ps.*) as count from regions as r
    inner join projects_regions as pr on r.id=pr.region_id
    inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{site.id}
    inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
    where r.level=#{site.level_for_region} and r.country_id=#{self.id}
    group by r.id,r.name order by count DESC"
    Region.find_by_sql(sql).map do |r|
      [r,r.count.to_i]
    end
  end

  def donors_count(site)
    ActiveRecord::Base.connection.execute(<<-SQL
      select count(distinct(donor_id)) as count from donations as d
      inner join projects as p on d.project_id = p.id and (p.end_date is null OR p.end_date > now())
      inner join projects_sites as ps on d.project_id=ps.project_id and ps.site_id=#{site.id}
      inner join countries_projects as cp on ps.project_id=cp.project_id and cp.country_id=#{self.id}
    SQL
    ).first['count'].to_i
  end

  def donors(site, limit = nil)
    limit = ''
    limit = "LIMIT #{limit}" if limit.present?

    sql="select donors.* from donors
    inner join donations as d on donors.id=d.donor_id
    inner join projects as p on d.project_id = p.id and (p.end_date is null OR p.end_date > now())
    inner join projects_sites as ps on d.project_id=ps.project_id and ps.site_id=#{site.id}
    inner join countries_projects as cp on ps.project_id=cp.project_id and cp.country_id=#{self.id}
    #{limit}"

    Donor.find_by_sql(sql).uniq
  end

  # to get only id and name
  def self.get_select_values
    scoped.select("id,name").order("name ASC")
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
    Country.find_by_sql(<<-SQL
      select * from
      (select co.id, co.name,
           ST_Distance((select ST_Centroid(the_geom) from regions where id=#{self.id}), ST_Centroid(the_geom)) as dist,
           (
            select count(*) from countries_projects as cp
            inner join projects as p on p.id=cp.project_id and (p.end_date is null OR p.end_date > now())
            inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=#{site.id}
            where country_id=co.id
          ) as count
           from countries as co
           where id!=#{self.id}
           order by dist
      ) as subq
      where count>0
      order by count DESC
      limit  #{limit};
SQL
    )
  end

  def projects_count(site, category_id = nil)
    if category_id.present?
      if site.navigate_by_cluster?
        category_join = "inner join clusters_projects as cp on cp.project_id = p.id and cp.cluster_id = #{category_id}"
      else
        category_join = "inner join projects_sectors as pse on pse.project_id = p.id and pse.sector_id = #{category_id}"
      end
    end

    sql = "select count(distinct(cp.project_id)) as count from countries_projects as cp
    inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=#{site.id}
    inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
    #{category_join}
    where cp.country_id=#{self.id} order by count DESC"
    ActiveRecord::Base.connection.execute(sql).first['count'].to_i
  end

  def projects_for_csv(site)
    sql = "select p.id, p.name, p.description, p.primary_organization_id, p.implementing_organization, p.partner_organizations, p.cross_cutting_issues, p.start_date, p.end_date, p.budget, p.target, p.estimated_people_reached, p.contact_person, p.contact_email, p.contact_phone_number, p.site_specific_information, p.created_at, p.updated_at, p.activities, p.intervention_id, p.additional_information, p.awardee_type, p.date_provided, p.date_updated, p.contact_position, p.website, p.verbatim_location, p.calculation_of_number_of_people_reached, p.project_needs, p.idprefugee_camp
    from countries_projects as cp
    inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=#{site.id}
    inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
    where cp.country_id=#{self.id}"
    ActiveRecord::Base.connection.execute(sql)
  end

  def projects_for_kml(site)
    sql = "select p.name, ST_AsKML(p.the_geom) as the_geom
    from countries_projects as cp
    inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=#{site.id}
    inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
    where cp.country_id=#{self.id}"
    ActiveRecord::Base.connection.execute(sql)
  end

  def to_param
    [self.id]
  end

end
