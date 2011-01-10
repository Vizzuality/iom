class CreateGeoiqViews < ActiveRecord::Migration
  def self.up
    execute "CREATE OR REPLACE VIEW v_regions_num_projects AS
    SELECT r3.id AS region_id, r3.name,
    count(p.id) AS num_projects, 
    st_astext(st_makepoint(r3.center_lon,r3.center_lat)) AS geom,
    'http://haiti.ngoaidmap.org/location/'|| r3.country_id ||'/'||r2.parent_region_id||'/'||r2.id||'/'||r3.id as url
       FROM regions as r3
       INNER JOIN regions as r2 on r3.parent_region_id=r2.id
       INNER JOIN projects_regions as pr ON r3.id = pr.region_id
       INNER JOIN projects as p ON pr.project_id = p.id
       INNER JOIN projects_sites as ps ON p.id = ps.project_id
       where r3.level=3 and ps.site_id=1
      GROUP BY r3.id, r3.name, geom,url;"              
    execute "insert into geometry_columns VALUES('','public','v_regions_num_projects','the_geom',2,'4326','MULTIPOINT')"
    
    execute "create or replace view v_projects as SELECT p.id, p.primary_organization_id,
              CASE WHEN p.end_date < now() OR p.end_date is null THEN false ELSE true END as is_active,
     ST_AsText(p.the_geom) as the_geom, 

        '|'||array_to_string(array_agg(distinct projects_sites.site_id),'|')||'|' as sites,
        '|'||array_to_string(array_agg(distinct countries_projects.country_id),'|')||'|' as countries,
        '|'||array_to_string(array_agg(distinct clusters_projects.cluster_id),'|')||'|' as clusters,
        '|'||array_to_string(array_agg(distinct projects_tags.tag_id),'|')||'|' as tags,
        '|'||array_to_string(array_agg(distinct projects_sectors.sector_id),'|')||'|' as sectors,

        '|'||(SELECT 
        array_to_string(array_agg(distinct regions.name),' | ')
        FROM (projects_regions RIGHT JOIN projects ON projects_regions.project_id = projects.id) LEFT JOIN regions ON projects_regions.region_id = regions.id
        WHERE (((projects.id)=p.id) AND ((regions.level)=1)))||'|' as regions_level1,

        '|'||(SELECT 
        array_to_string(array_agg(distinct regions.name),' | ')
        FROM (projects_regions RIGHT JOIN projects ON projects_regions.project_id = projects.id) LEFT JOIN regions ON projects_regions.region_id = regions.id
        WHERE (((projects.id)=p.id) AND ((regions.level)=2)))||'|' as regions_level2,

        '|'||(SELECT 
        array_to_string(array_agg(distinct regions.name),' | ')
        FROM (projects_regions RIGHT JOIN projects ON projects_regions.project_id = projects.id) LEFT JOIN regions ON projects_regions.region_id = regions.id
        WHERE (((projects.id)=p.id) AND ((regions.level)=3)))||'|' as regions_level3

        FROM ((((projects as p LEFT JOIN projects_sectors ON p.id = projects_sectors.project_id) LEFT JOIN clusters_projects ON p.id = clusters_projects.project_id) 
        LEFT JOIN countries_projects ON p.id = countries_projects.project_id) 
        LEFT JOIN projects_tags ON p.id = projects_tags.project_id)
        LEFT JOIN projects_sites ON p.id = projects_sites.project_id
        group by p.id, p.primary_organization_id, p.start_date, p.end_date, p.the_geom;"              
    execute "insert into geometry_columns VALUES('','public','v_projects','the_geom',2,'4326','MULTIPOINT')"
    
    #Create a geoiq user and give him permissions:
    execute "DROP ROLE IF EXISTS geoiq;"
    execute "CREATE ROLE geoiq LOGIN ENCRYPTED PASSWORD 'md54c67ea040991d532eb7586d147a178b5' VALID UNTIL 'infinity';"
    execute "GRANT SELECT ON TABLE v_projects TO geoiq;"
    execute "GRANT SELECT ON TABLE v_regions_num_projects TO geoiq;"
    
  end

  def self.down
  end
end
