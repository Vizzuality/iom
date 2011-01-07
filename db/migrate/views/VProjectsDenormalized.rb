class VProjectsDenormalized < SqlView
  view_name :v_projects_denormalized

  sql <<-SQL
      SELECT
      p.id, o.name,o.id as organization_id, p.start_date, p.end_date, st_askml(p.the_geom) AS the_geom,
      implementing_organization,partner_organizations,cross_cutting_issues,p.budget,target,p.estimated_people_reached,contact_person,
      p.contact_email,p.contact_phone_number,activities,additional_information,p.contact_position,p.website,
      array_to_string(array_agg(DISTINCT projects_sites.site_id), '|'::text) AS sites,
      array_to_string(array_agg(DISTINCT coun.name), '|'::text) AS countries,
      array_to_string(array_agg(DISTINCT clus.name), '|'::text) AS clusters,
      array_to_string(array_agg(DISTINCT projects_tags.tag_id), '|'::text) AS tags,
      array_to_string(array_agg(DISTINCT sec.name), '|'::text) AS sectors,
      (SELECT array_to_string(array_agg(DISTINCT regions.name), ' | '::text) AS array_to_string
      FROM projects_regions

      RIGHT JOIN projects ON projects_regions.project_id = projects.id
      LEFT JOIN regions ON projects_regions.region_id = regions.id
      WHERE projects.id = p.id AND regions.level = 1) AS regions_level1, ( SELECT array_to_string(array_agg(DISTINCT regions.name), ' | '::text) AS array_to_string

      FROM projects_regions
            RIGHT JOIN projects ON projects_regions.project_id = projects.id
         LEFT JOIN regions ON projects_regions.region_id = regions.id
        WHERE projects.id = p.id AND regions.level = 2) AS regions_level2, ( SELECT array_to_string(array_agg(DISTINCT regions.name), ' | '::text) AS array_to_string
                 FROM projects_regions
            RIGHT JOIN projects ON projects_regions.project_id = projects.id
         LEFT JOIN regions ON projects_regions.region_id = regions.id
        WHERE projects.id = p.id AND regions.level = 3) AS regions_level3
         FROM projects p
         LEFT JOIN organizations as o ON p.primary_organization_id=o.id
         LEFT JOIN projects_sectors ON p.id = projects_sectors.project_id
         LEFT JOIN sectors as sec ON projects_sectors.sector_id=sec.id
         LEFT JOIN clusters_projects ON p.id = clusters_projects.project_id
         LEFT JOIN clusters as clus ON clusters_projects.cluster_id=clus.id
         LEFT JOIN countries_projects ON p.id = countries_projects.project_id
         LEFT JOIN countries as coun ON countries_projects.country_id=coun.id
         LEFT JOIN projects_tags ON p.id = projects_tags.project_id
         LEFT JOIN projects_sites ON p.id = projects_sites.project_id
        GROUP BY p.id, o.name,o.id, p.start_date, p.end_date, p.the_geom,
        implementing_organization,partner_organizations,cross_cutting_issues,start_date,end_date,p.budget,target,
        p.estimated_people_reached,contact_person,p.contact_email,p.contact_phone_number,activities,additional_information,p.contact_position,p.website
  SQL
end