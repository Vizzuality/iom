# == Schema Information
#
# Table name: regions
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  level            :integer
#  country_id       :integer
#  parent_region_id :integer
#  gadm_id          :integer
#  wiki_url         :string(255)
#  wiki_description :text
#  code             :string(255)
#  the_geom         :string
#

class Region < ActiveRecord::Base

  belongs_to :country
  belongs_to :region, :foreign_key => :parent_region_id, :class_name => 'Region'

  has_and_belongs_to_many :projects do
    def site(site)
      self.where("projects.id IN (#{site.projects_ids.join(',')})")
    end
  end

  before_save :update_wikipedia_description

  def self.custom_fields
    (columns.map{ |c| c.name } - ['the_geom']).map{ |c| "#{self.table_name}.#{c}" }
  end

  # Array of arrays
  # [[cluster, count], [cluster, count]]
  def projects_clusters(site)
    result = ActiveRecord::Base.connection.execute("select cluster_id, count(cluster_id) as count from clusters_projects where project_id IN (select project_id from projects_regions where region_id=#{self.id}) AND project_id IN (#{site.projects_ids.join(',')}) group by cluster_id order by count desc")
    result.map do |row|
      [Cluster.find(row['cluster_id']), row['count'].to_i]
    end
  end

  # Array of arrays
  # [[organization, count], [organization, count]]
  def projects_organizations(site)
    result = ActiveRecord::Base.connection.execute("select primary_organization_id, count(primary_organization_id) as count from projects where id IN (select project_id from projects_regions where region_id=#{self.id}) AND id IN (#{site.projects_ids.join(',')}) group by primary_organization_id order by count desc")
    result.map do |row|
      [Organization.find(row['primary_organization_id']), row['count'].to_i]
    end
  end

  def donors_count(site)
    ActiveRecord::Base.connection.execute(<<-SQL
      select count(distinct(donations.donor_id)) as count from donations where donations.project_id IN (#{(projects.site(site).map{ |s| s.id } + [-1]).join(',')})
    SQL
    ).first['count'].to_i
  end

  def donors(site, limit = 11)
    result = []
    projects.site(site).map do |project|
      result += project.donors.flatten.uniq
      break if result.size > limit
    end
    result[0...limit]
  end

  def donors_budget(site)
    amount = 0
    donors(site).each { |donor| amount += donor.donations_amount }
    return amount
  end

  def self.get_select_values
    scoped.select(:id,:name).order("name ASC")
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

  def near(limit = 5)
    Region.find_by_sql(<<-SQL
      select #{Region.custom_fields.join(',')},
            ST_Distance((select ST_Centroid(the_geom) from regions where id=#{self.id}), ST_Centroid(the_geom)) as dist
            from regions
            where id!=#{self.id}
            and the_geom is not null
            order by dist
            limit #{limit}
SQL
    )
  end

end
