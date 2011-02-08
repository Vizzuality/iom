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

  def donors(site, limit = 10)
    sql="select donors.* from donors
    inner join donations as d on donors.id=d.donor_id
    inner join projects as p on d.project_id = p.id and (p.end_date is null OR p.end_date > now())
    inner join projects_sites as ps on d.project_id=ps.project_id and ps.site_id=#{site.id}
    inner join countries_projects as cp on ps.project_id=cp.project_id and cp.country_id=#{self.id}
    LIMIT #{limit}"
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
           ST_Distance((select ST_Centroid(the_geom) from countries where id=#{self.id}), ST_Centroid(the_geom)) as dist,
           (select count(*) from countries_projects as cp
           inner join projects_sites on projects_sites.project_id=cp.project_id and projects_sites.site_id=#{site.id}
           where country_id=co.id) as count
           from countries as co
           where id!=#{self.id}
           order by dist
      ) as subq
      where count>0
      order by count desc
      limit  #{limit}
SQL
    )
  end

  def projects_count(site)
    sql = "select count(distinct(cp.project_id)) as count from countries_projects as cp
    inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=#{site.id}
    inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
    where cp.country_id=#{self.id} order by count DESC"
    ActiveRecord::Base.connection.execute(sql).first['count'].to_i
  end

  def to_param
    [self.id]
  end

end
