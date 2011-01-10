# == Schema Information
#
# Table name: regions
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  level            :integer
#  country_id       :integer
#  parent_region_id :integer
#  the_geom         :string
#  gadm_id          :integer
#  wiki_url         :string(255)
#  wiki_description :text
#  code             :string(255)
#  center_lat       :float
#  center_lon       :float
#  the_geom_geojson :text
#  ia_name          :text
#  path             :string(255)
#

class Region < ActiveRecord::Base

  belongs_to :country
  belongs_to :region, :foreign_key => :parent_region_id, :class_name => 'Region'

  has_and_belongs_to_many :projects

  before_save :update_wikipedia_description

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

  def donors(site, limit = 11)
    sql="select distinct don.* from projects_sites as ps
    inner join donations as d on ps.project_id=d.project_id and ps.site_id=#{site.id}
    inner join donors as don on don.id=d.donor_id
    inner join projects_regions as pr on ps.project_id=pr.project_id and region_id=#{self.id}
    limit #{limit}"
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
        order by count DESC
        limit  #{limit}
SQL
      )
    else
      Region.find_by_sql(<<-SQL
        select * from
        (select re.id, re.name, re.level, re.country_id, re.parent_region_id, re.path,
             ST_Distance((select ST_Centroid(the_geom) from regions where id=#{self.id}), ST_Centroid(the_geom)) as dist,
             (select count(*) from projects_regions as pr where region_id=re.id) as count
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

  def projects_count(site)
    sql = "select count(distinct(pr.project_id)) as count from projects_regions as pr
    inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{site.id}
    inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
    where pr.region_id=#{self.id}"
    ActiveRecord::Base.connection.execute(sql).first['count'].to_i
  end

  def to_param
    self.path
  end

end
