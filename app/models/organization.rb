# == Schema Information
#
# Table name: organizations
#
#  id                              :integer         not null, primary key
#  name                            :string(255)
#  description                     :text
#  budget                          :float
#  website                         :string(255)
#  national_staff                  :integer
#  twitter                         :string(255)
#  facebook                        :string(255)
#  hq_address                      :string(255)
#  contact_email                   :string(255)
#  contact_phone_number            :string(255)
#  donation_address                :string(255)
#  zip_code                        :string(255)
#  city                            :string(255)
#  state                           :string(255)
#  donation_phone_number           :string(255)
#  donation_website                :string(255)
#  site_specific_information       :text
#  created_at                      :datetime
#  updated_at                      :datetime
#  logo_file_name                  :string(255)
#  logo_content_type               :string(255)
#  logo_file_size                  :integer
#  logo_updated_at                 :datetime
#  international_staff             :string(255)
#  contact_name                    :string(255)
#  contact_position                :string(255)
#  contact_zip                     :string(255)
#  contact_city                    :string(255)
#  contact_state                   :string(255)
#  contact_country                 :string(255)
#  donation_country                :string(255)
#  estimated_people_reached        :integer
#  private_funding                 :float
#  usg_funding                     :float
#  other_funding                   :float
#  private_funding_spent           :float
#  usg_funding_spent               :float
#  other_funding_spent             :float
#  spent_funding_on_relief         :float
#  spent_funding_on_reconstruction :float
#  percen_relief                   :integer
#  percen_reconstruction           :integer
#  media_contact_name              :string(255)
#  media_contact_position          :string(255)
#  media_contact_phone_number      :string(255)
#  media_contact_email             :string(255)
#

class Organization < ActiveRecord::Base

  has_many :resources, :conditions => 'resources.element_type = #{Iom::ActsAsResource::ORGANIZATION_TYPE}', :foreign_key => :element_id, :dependent => :destroy
  has_many :media_resources, :conditions => 'media_resources.element_type = #{Iom::ActsAsResource::ORGANIZATION_TYPE}', :foreign_key => :element_id, :dependent => :destroy, :order => 'position ASC'
  has_many :projects, :foreign_key => :primary_organization_id

  has_attached_file :logo, :styles => {
                                      :small => {
                                        :geometry => "80x46>",
                                        :format => 'jpg'
                                      }
                                    },
                            :url => "/system/:attachment/:id/:style.:extension"

  has_many :sites, :foreign_key => :project_context_organization_id
  has_many :donations, :through => :projects

  validates_presence_of :name

  serialize :site_specific_information

  # Attributes for site getter
  def attributes_for_site(site)
    atts = site_specific_information || {}
    if atts[site.id.to_s]
      atts[site.id.to_s].reject{|key,value| value.nil? }
    else
      atts[site.id.to_s] = {}
      atts[site.id.to_s]
    end
  end

  # Attributes for site setter
  def attributes_for_site=(value)
    atts = site_specific_information || {}
    atts[value[:site_id].to_s] = value[:organization_values]

    # Funding values set to float
    if atts[value[:site_id].to_s][:usg_funding]
      if atts[value[:site_id].to_s][:usg_funding].is_a?(String)
        atts[value[:site_id].to_s][:usg_funding] = atts[value[:site_id].to_s][:usg_funding].delete(',').to_f
      end
    else
      atts[value[:site_id].to_s][:usg_funding] = 0.0
    end
    if atts[value[:site_id].to_s][:private_funding]
      if atts[value[:site_id].to_s][:private_funding].is_a?(String)
        atts[value[:site_id].to_s][:private_funding] = atts[value[:site_id].to_s][:private_funding].delete(',').to_f
      end
    else
      atts[value[:site_id].to_s][:private_funding] = 0.0
    end
    if atts[value[:site_id].to_s][:other_funding]
      if atts[value[:site_id].to_s][:other_funding].is_a?(String)
        atts[value[:site_id].to_s][:other_funding] = atts[value[:site_id].to_s][:other_funding].delete(',').to_f
      end
    else
      atts[value[:site_id].to_s][:other_funding] = 0.0
    end

    update_attribute(:site_specific_information, atts)
  end

  def donors_count
    @donors_count ||= donations.map{ |d| d.donor_id }.uniq.size
  end

  def resources_for_site(site)
    resources.select{ |r| r.sites_ids.include?(site.id.to_s) }
  end

  # Array of arrays
  # [[cluster, count], [cluster, count]]
  def projects_clusters_sectors(site, location_id = nil)
    if location_id.present?
      if site.navigate_by_country
        location_join = "inner join countries_projects cp on cp.project_id = p.id and cp.country_id = #{location_id.first}"
      else
        location_join = "inner join projects_regions as pr on pr.project_id = p.id and pr.region_id = #{location_id.last}"
      end
    end

    if site.navigate_by_cluster?
      sql="select c.id,c.name,count(ps.*) as count from clusters as c
      inner join clusters_projects as cp on c.id=cp.cluster_id
      inner join projects as p on p.id=cp.project_id and (p.end_date is null OR p.end_date > now())
      inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{site.id}
      #{location_join}
      where p.primary_organization_id=#{self.id}
      group by c.id,c.name order by count DESC"
      Cluster.find_by_sql(sql).map do |c|
        [c,c.count.to_i]
      end
    else
      sql="select s.id,s.name,count(ps.*) as count from sectors as s
      inner join projects_sectors as pjs on s.id=pjs.sector_id
      inner join projects as p on p.id=pjs.project_id and (p.end_date is null OR p.end_date > now())
      inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{site.id}
      #{location_join}
      where p.primary_organization_id=#{self.id}
      group by s.id,s.name order by count DESC"
      Sector.find_by_sql(sql).map do |s|
        [s,s.count.to_i]
      end
    end
  end

  # Array of arrays
  # [[region, count], [region, count]]
  def projects_regions(site, category_id = nil)
    if category_id.present?
      if site.navigate_by_cluster?
        category_join = "inner join clusters_projects as cp on cp.project_id = p.id and cp.cluster_id = #{category_id}"
      else
        category_join = "inner join projects_sectors as pse on pse.project_id = p.id and pse.sector_id = #{category_id}"
      end
    end

    Region.find_by_sql(
<<-SQL
select r.id,r.name,r.level,r.parent_region_id, r.path, r.country_id,count(ps.*) as count from regions as r
  inner join projects_regions as pr on r.id=pr.region_id
  inner join projects as p on p.id=pr.project_id and (p.end_date is null OR p.end_date > now())
  inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{site.id}
  #{category_join}
  where p.primary_organization_id=#{self.id}
        and r.level=#{site.level_for_region}
  group by r.id,r.name,r.level,r.parent_region_id, r.path, r.country_id order by count DESC
SQL
    ).map do |r|
      [r, r.count.to_i]
    end
  end

  # Array of arrays
  # [[country, count], [country, count]]
  def projects_countries(site, category_id = nil)
    if category_id.present?
      if site.navigate_by_cluster?
        category_join = "inner join clusters_projects as cp on cp.project_id = p.id and cp.cluster_id = #{category_id}"
      else
        category_join = "inner join projects_sectors as pse on pse.project_id = p.id and pse.sector_id = #{category_id}"
      end
    end

    Country.find_by_sql(
<<-SQL
select c.id,c.name,count(ps.*) as count from countries as c
  inner join countries_projects as pr on c.id=pr.country_id
  inner join projects as p on p.id=pr.project_id and (p.end_date is null OR p.end_date > now())
  inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{site.id}
  #{category_join}
  where p.primary_organization_id=#{self.id}
  group by c.id, c.name order by count DESC
SQL
    ).map do |r|
      [r, r.count.to_i]
    end
  end

  def projects_file=(file)
    return if file.blank?
    projects_ids_to_delete = self.project_ids || []

    csv_projects = []

    CsvMapper.import(file, :type => :io) do
      map_to Project
      after_row lambda{ |row, project|
        csv_projects << project
      }

      start_at_row 1
      read_attributes_from_file
    end

    Project.delete(projects_ids_to_delete - csv_projects.map{|p| p.id})

    organization = self
    csv_projects.each do |project|
      if organization.projects.exists? :id => project.id
        project.primary_organization = organization
        organization.projects.find(project.id).update_attributes project.attributes
      else
        organization.projects << project
      end
    end
  end

  def sync_projects(file)
    return if file.blank? || file.tempfile.blank?
    projects_ids_to_delete = self.project_ids || []

    csv_projects = []

    csv_projects = CsvMapper.import(file.tempfile, :type => :io) do
      delimited_by ';'
      parser_options :col_sep => ';', :converters => :all
      start_at_row 1
      read_attributes_from_file({
        'project_id'                              => 'id',
        'intervention_id'                         => 'intervention_id',
        'project_name'                            => 'name',
        'project_description'                     => 'description',
        'organization_id'                         => 'primary_organization_id',
        'implementing_organization'               => 'implementing_organization',
        'project_contact_phone_number'            => 'contact_phone_number',
        'start_date'                              => 'start_date',
        'end_date'                                => 'end_date',
        'date_provided'                           => 'date_provided',
        'date_updated'                            => 'date_updated',
        'verbatim_location'                       => 'verbatim_location',
        'project_contact_email'                   => 'contact_email',
        'additional_information'                  => 'additional_information',
        'partner_organizations'                   => 'partner_organizations',
        'project_needs'                           => 'project_needs',
        'project_contact_person'                  => 'contact_person',
        'project_contact_position'                => 'contact_position',
        'estimated_people_reached'                => 'estimated_people_reached',
        'calculation_of_number_of_people_reached' => 'calculation_of_number_of_people_reached',
        'awardee_type'                            => 'awardee_type',
        'target'                                  => 'target',
        'budget'                                  => 'budget',
        'project_website'                         => 'website',
        'cross_cutting_issues'                    => 'cross_cutting_issues',
        'countries'                               => 'countries',
        'regions_level1'                          => 'first_admin_level',
        'regions_level2'                          => 'second_admin_level',
        'regions_level3'                          => 'third_admin_level',
        'clusters'                                => 'clusters',
        'sectors'                                 => 'sectors',
        'donors'                                  => 'donors',
        'project_tags'                            => 'project_tags',
        'activities'                              => 'activities',
        'organization_name'                       => 'organization_name',
        'site_id'                                 => 'site_id'
      })
    end

    return if csv_projects.empty?

    rows_with_errors = []
    organization = self
    csv_projects.each do |csv_project|
      csv_hash = Hash[*(csv_projects.first.members).zip(csv_project.values).flatten]
      errors = []
      project_hash = csv_hash.slice(*Project.columns_hash.keys)

      if project_hash['id'].present?
        project = Project.where(:id => project_hash.delete('id')).first
      else
        project = Project.new
      end

      project.attributes = project_hash
      project.primary_organization = self

      if csv_hash['countries'] && (countries = csv_hash['countries'].split(',')) && countries.present?
        project.countries.clear
        countries.each do |country_name|
          country = Country.where(:name => country_name).first
          if country.blank?
            errors << "Country #{country_name} doesn't exist"
            next
          end
          project.countries << country
        end
      end

      if csv_hash['first_admin_level'] && (first_admin_levels = csv_hash['first_admin_level'].split(',')) && first_admin_levels.present?
        project.regions.where(:level => 1).clear
        first_admin_levels.each do |first_admin_level_name|
          region = Region.where(:name => first_admin_level_name).first
          if region.blank?
            errors << "1st Admin level #{first_admin_level_name} doesn't exist"
            next
          end
          project.regions << region
        end
      end

      if csv_hash['second_admin_level'] && (second_admin_levels = csv_hash['second_admin_level'].split(',')) && second_admin_levels.present?
        project.regions.where(:level => 2).clear
        second_admin_levels.each do |second_admin_level_name|
          region = Region.where(:name => second_admin_level_name).first
          if region.blank?
            errors << "2nd Admin level #{second_admin_level_name} doesn't exist"
            next
          end
          project.regions << region
        end
      end

      if csv_hash['third_admin_level'] && (third_admin_levels = csv_hash['third_admin_level'].split(',')) && third_admin_levels.present?
        project.regions.where(:level => 3).clear
        third_admin_levels.each do |third_admin_level_name|
          region = Region.where(:name => third_admin_level_name).first
          if region.blank?
            errors << "3rd Admin level #{third_admin_level_name} doesn't exist"
            next
          end
          project.regions << region
        end
      end

      if csv_hash['sectors'] && (sectors = csv_hash['sectors'].split(',')) && sectors.present?
        project.sectors.clear
        sectors.each do |sector_name|
          sector = Sector.where(:name => sector_name).first
          if sector.blank?
            errors << "Sector #{sector_name} doesn't exist"
            next
          end
          project.sectors << sector
        end
      end


      if csv_hash['clusters'] && (clusters = csv_hash['clusters'].split(',')) && clusters.present?
        project.clusters.clear
        clusters.each do |cluster_name|
          cluster = Cluster.where(:name => cluster_name).first
          if cluster.blank?
            errors << "cluster #{cluster_name} doesn't exist"
            next
          end
          project.clusters << cluster
        end
      end

      if csv_hash['donors'] && (donors = csv_hash['donors'].split(',')) && donors.present?
        project.donors.clear
        donors.each do |donor_name|
          donor = Donor.where(:name => donor_name).first
          if donor.blank?
            errors << "donor #{donor_name} doesn't exist"
            next
          end
          project.donors << donor
        end
      end

      if csv_hash['project_tags'] && (project_tags = csv_hash['project_tags'].split(',')) && project_tags.present?
        project.tags.clear
        project_tags.each do |project_tag_name|
          project_tag = Tag.find_or_create_by_name(project_tag_name)
          project.tags << project_tag
        end
      end

      unless project.save
        errors += project.errors.full_messages
      end

      if errors.present?
        errors.insert(0, 'The following errors were found:')
        rows_with_errors << {
          'project_id'                              => csv_project.id,
          'intervention_id'                         => csv_project.intervention_id,
          'project_name'                            => csv_project.name,
          'project_description'                     => csv_project.description,
          'organization_id'                         => csv_project.primary_organization_id,
          'implementing_organization'               => csv_project.implementing_organization,
          'project_contact_phone_number'            => csv_project.contact_phone_number,
          'start_date'                              => csv_project.start_date,
          'end_date'                                => csv_project.end_date,
          'date_provided'                           => csv_project.date_provided,
          'date_updated'                            => csv_project.date_updated,
          'verbatim_location'                       => csv_project.verbatim_location,
          'project_contact_email'                   => csv_project.contact_email,
          'additional_information'                  => csv_project.additional_information,
          'partner_organizations'                   => csv_project.partner_organizations,
          'project_needs'                           => csv_project.project_needs,
          'project_contact_person'                  => csv_project.contact_person,
          'project_contact_position'                => csv_project.contact_position,
          'estimated_people_reached'                => csv_project.estimated_people_reached,
          'calculation_of_number_of_people_reached' => csv_project.calculation_of_number_of_people_reached,
          'awardee_type'                            => csv_project.awardee_type,
          'target'                                  => csv_project.target,
          'budget'                                  => csv_project.budget,
          'project_website'                         => csv_project.website,
          'cross_cutting_issues'                    => csv_project.cross_cutting_issues,
          'countries'                               => csv_project.countries,
          'regions_level1'                          => csv_project.first_admin_level,
          'regions_level2'                          => csv_project.second_admin_level,
          'regions_level3'                          => csv_project.third_admin_level,
          'clusters'                                => csv_project.clusters,
          'sectors'                                 => csv_project.sectors,
          'donors'                                  => csv_project.donors,
          'project_tags'                            => csv_project.project_tags,
          'activities'                              => csv_project.activities,
          'organization_name'                       => csv_project.organization_name,
          'site_id'                                 => csv_project.site_id,
          'Errors'                                  => errors.join("\n")
        }

      end
    end
    rows_with_errors
  end

  def budget(site)
    atts_for_site = attributes_for_site(site)
    return (atts_for_site[:usg_funding].to_f || 0) + (atts_for_site[:private_funding].to_f || 0) + (atts_for_site[:other_funding].to_f || 0)
  end

  # to get only id and name
  def self.get_select_values
    scoped.select("id,name").order("name ASC")
  end

  def projects_count(site, category_id = nil, location_id = nil)

    if category_id.present?
      if site.navigate_by_cluster?
        category_join = "inner join clusters_projects as cp on cp.project_id = p.id and cp.cluster_id = #{category_id}"
      else
        category_join = "inner join projects_sectors as pse on pse.project_id = p.id and pse.sector_id = #{category_id}"
      end
    end

    if location_id.present?
      if site.navigate_by_country
        location_join = "inner join countries_projects cp on cp.project_id = p.id and cp.country_id = #{location_id.first}"
      else
        location_join = "inner join projects_regions as pr on pr.project_id = p.id and pr.region_id = #{location_id.last}"
      end
    end

    sql = "select count(p.id) as count from projects as p
    inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{site.id}
    #{category_join}
    #{location_join}
    where p.primary_organization_id=#{self.id} and (p.end_date is null OR p.end_date > now())"
    ActiveRecord::Base.connection.execute(sql).first['count'].to_i
  end

  def projects_for_csv(site)
    sql = "select p.id, p.name, p.description, p.primary_organization_id, p.implementing_organization, p.partner_organizations, p.cross_cutting_issues, p.start_date, p.end_date, p.budget, p.target, p.estimated_people_reached, p.contact_person, p.contact_email, p.contact_phone_number, p.site_specific_information, p.created_at, p.updated_at, p.activities, p.intervention_id, p.additional_information, p.awardee_type, p.date_provided, p.date_updated, p.contact_position, p.website, p.verbatim_location, p.calculation_of_number_of_people_reached, p.project_needs, p.idprefugee_camp
    from projects as p
    inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{site.id}
    where p.primary_organization_id=#{self.id} and (p.end_date is null OR p.end_date > now())"
    ActiveRecord::Base.connection.execute(sql)
  end

  def projects_for_kml(site)
    sql = "select p.name, ST_AsKML(p.the_geom) as the_geom
    from projects as p
    inner join projects_sites as ps on p.id=ps.project_id and ps.site_id=#{site.id}
    where p.primary_organization_id=#{self.id} and (p.end_date is null OR p.end_date > now())"
    ActiveRecord::Base.connection.execute(sql)
  end


  def total_regions(site)
    sql = "select count(distinct(pr.region_id)) as count from projects_regions as pr
    inner join regions as r on pr.region_id=r.id and level=#{site.level_for_region}
    inner join projects as p on p.id=pr.project_id and (p.end_date is null OR p.end_date > now())
                                and p.primary_organization_id=#{self.id}
    inner join projects_sites as psi on p.id=psi.project_id and psi.site_id=#{site.id}"
    ActiveRecord::Base.connection.execute(sql).first['count'].to_i
  end

  def total_countries(site)
    sql = "select count(distinct(pr.country_id)) as count from countries_projects as pr
    inner join projects as p on p.id=pr.project_id and (p.end_date is null OR p.end_date > now())
                                and p.primary_organization_id=#{self.id}
    inner join projects_sites as psi on p.id=psi.project_id and psi.site_id=#{site.id}"
    ActiveRecord::Base.connection.execute(sql).first['count'].to_i
  end

end
