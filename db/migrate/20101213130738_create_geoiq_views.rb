class CreateGeoiqViews < ActiveRecord::Migration
  def self.up
    execute "create or replace view v_regions_num_projects as
    SELECT  regions.id as region_id,regions.name, regions.level, regions.parent_region_id,regions.country_id, projects_sites.site_id,
    count(projects.id) as num_projects,ST_AsText(regions.the_geom) as the_geom

    FROM ((regions INNER JOIN projects_regions ON regions.id = projects_regions.region_id) 
    INNER JOIN projects ON projects_regions.project_id = projects.id) 
    INNER JOIN projects_sites ON projects.id = projects_sites.project_id

    group by regions.id,projects_sites.site_id,regions.name, regions.level, regions.country_id,regions.parent_region_id,regions.the_geom;"              
    execute "insert into geometry_columns VALUES('','public','v_regions_num_projects','the_geom',2,'4326','MULTIPOINT')"
    
    execute "create or replace view v_projects as SELECT p.id, p.primary_organization_id, p.start_date, p.end_date, ST_AsText(p.the_geom) as the_geom, 

    array_to_string(array_agg(distinct projects_sites.site_id),'|') as sites,
    array_to_string(array_agg(distinct countries_projects.country_id),'|') as countries,
    array_to_string(array_agg(distinct clusters_projects.cluster_id),'|') as clusters,
    array_to_string(array_agg(distinct projects_tags.tag_id),'|') as tags,
    array_to_string(array_agg(distinct projects_sectors.sector_id),'|') as sectors,

    (SELECT 
    array_to_string(array_agg(distinct regions.name),' | ')
    FROM (projects_regions RIGHT JOIN projects ON projects_regions.project_id = projects.id) LEFT JOIN regions ON projects_regions.region_id = regions.id
    WHERE (((projects.id)=p.id) AND ((regions.level)=1))) as regions_level1,

    (SELECT 
    array_to_string(array_agg(distinct regions.name),' | ')
    FROM (projects_regions RIGHT JOIN projects ON projects_regions.project_id = projects.id) LEFT JOIN regions ON projects_regions.region_id = regions.id
    WHERE (((projects.id)=p.id) AND ((regions.level)=2))) as regions_level2,

    (SELECT 
    array_to_string(array_agg(distinct regions.name),' | ')
    FROM (projects_regions RIGHT JOIN projects ON projects_regions.project_id = projects.id) LEFT JOIN regions ON projects_regions.region_id = regions.id
    WHERE (((projects.id)=p.id) AND ((regions.level)=3))) as regions_level3

    FROM ((((projects as p LEFT JOIN projects_sectors ON p.id = projects_sectors.project_id) LEFT JOIN clusters_projects ON p.id = clusters_projects.project_id) 
    LEFT JOIN countries_projects ON p.id = countries_projects.project_id) 
    LEFT JOIN projects_tags ON p.id = projects_tags.project_id)
    LEFT JOIN projects_sites ON p.id = projects_sites.project_id
    group by p.id, p.primary_organization_id, p.start_date, p.end_date, p.the_geom;"              
    execute "insert into geometry_columns VALUES('','public','v_projects','the_geom',2,'4326','MULTIPOINT')"    
    
  end

  def self.down
  end
end
