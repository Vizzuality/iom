class Api::GeodataController < ApplicationController

  def countries
    sql="select c.id,count(ps.project_id) as num_projects,c.name,x(ST_Centroid(c.the_geom)) as lon,y(ST_Centroid(c.the_geom)) as lat
        from (countries_projects as cp inner join projects_sites as ps on cp.project_id=ps.project_id and site_id=#{@site.id}) inner join countries as c on cp.country_id=c.id
        group by c.id,c.name,lon,lat"
    
    result = ActiveRecord::Base.connection.execute(sql)
    
    respond_to do |format|
      format.json do 
        render :json => result.to_json
      end
    end
  end
  
  def regions
    sql="select r.id,count(ps.project_id) as num_projects,r.name,x(ST_Centroid(r.the_geom)) as lon,y(ST_Centroid(r.the_geom)) as lat,c.name
    from ((projects_regions as pr inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{@site.id}) 
    inner join regions as r on pr.region_id=r.id and r.level=3)
    inner join countries as c on r.country_id=c.id
    group by r.id,r.name,lon,lat,c.name"
    
    result = ActiveRecord::Base.connection.execute(sql)
    
    respond_to do |format|
      format.json do 
        render :json => result.to_json
      end
    end
  end  
  
  
end