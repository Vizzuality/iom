<?php

$csvpath = '/Users/jatorre/workspace/iom/lib/tasks/update-regions.csv';
$outputsql = '/Users/jatorre/workspace/iom/lib/tasks/update-regions.sql';

$csv = array_map("str_getcsv", file($csvpath,FILE_SKIP_EMPTY_LINES));
$keys = array_shift($csv);
foreach ($csv as $i=>$row) {
    $csv[$i] = array_combine($keys, $row);
}

#destination
$fp = fopen($outputsql, 'w');


#just in case we add some Foreign keys contrains
fwrite($fp, "ALTER TABLE projects_regions ADD CONSTRAINT region_id_fk 
    FOREIGN KEY (region_id) REFERENCES regions (id) ON UPDATE NO ACTION ON DELETE NO ACTION;\n");



#add south sudan
fwrite($fp, "INSERT INTO countries(id,name,center_lat,center_lon) VALUES (247,'South Sudan',7.089264,30.849609);\n");


#we start adding the new records
foreach ($csv as $r) {
    if($r['Edits']=='Add') {
        $r['new_id_assigned']= round($r['new_id_assigned']);
        $r['country_id']= round($r['country_id']);
        
        
        fwrite($fp, "INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (".$r['new_id_assigned'].",'".pg_escape_string($r['new_name'])."',1,".$r['country_id'].",
        ST_GeomFromtext('POINT(".$r['Longitude']." ".$r['Latitude'].")',4326),".$r['Latitude'].",
        ".$r['Longitude'].",'".$r['country_id']."/".$r['new_id_assigned']."');\n");
    }
}

#update records
foreach ($csv as $r) {
    if($r['Edits']=='Change') {
        $r['area_id']= round($r['area_id']);
        
        fwrite($fp, "UPDATE regions SET name = '".pg_escape_string($r['new_name'])."' WHERE id = ".$r['area_id'].";\n");
        if ($r['Latitude']!='' and $r['Longitude']!='') {
            fwrite($fp, "UPDATE regions SET the_geom = ST_GeomFromtext('POINT(".$r['Longitude']." ".$r['Latitude'].")',4326),
            center_lat=".$r['Latitude'].",
            center_lon=".$r['Longitude']."
             WHERE id = ".$r['area_id'].";\n");
        }
    }
}


#remove records
foreach ($csv as $r) {
    if($r['Edits']=='Delete') {        
        $r['area_id']= round($r['area_id']);
        $r['new_id_assigned']= round($r['new_id_assigned']);
        
        #for those with new IDs assigned lets reattached them
        if ($r['new_id_assigned']!='' and $r['new_id_assigned']!=$r['area_id']) {
            
            fwrite($fp, "UPDATE projects_regions SET region_id=".$r['new_id_assigned']." WHERE region_id=".$r['area_id'].";\n");
        }
        #And remove
        fwrite($fp, "DELETE FROM regions WHERE id=".$r['area_id'].";\n");
        

    }
}



#Adjustments for South Sudan
fwrite($fp, "DELETE FROM countries_projects WHERE country_id = 190:\n");

fwrite($fp, "INSERT INTO countries_projects(project_id,country_id)
select distinct project_id,r.country_id from projects_regions as pr inner join regions as r on pr.region_id = r.id
where r.country_id in (190,247);\n");

--




/*
$conn = pg_pconnect("host=localhost port=5432 dbname=iom_development user=postgres");

foreach ($csv as $r) {
    if($r['Edits']=='Delete') {        
        $r['area_id']= round($r['area_id']);
        if($r['new_id_assigned']=="") {
            $sql="SELECT count(*) from projects_regions WHERE region_id = ".$r['area_id'];
            $result = pg_query($conn, $sql);
            $arr = pg_fetch_array($result, NULL, PGSQL_ASSOC);
            if( $arr["count"] > 0) {
                echo("RegionID  ".$r['area_id']." has this proj: ".$arr["count"]."\n");
            }
            
        }
        

    }
}

*/





fclose($fp);

?>