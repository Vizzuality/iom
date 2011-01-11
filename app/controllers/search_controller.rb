class SearchController < ApplicationController

  layout 'site_layout'

  def index
    where  = ["is_active=true","site_id=#{@site.id}"]
    where_facet = []
    limit = 20
    @current_page = params[:page] ? params[:page].to_i : 1

    if params[:region_id] || params[:cluster_id] || params[:sector_id]
      if params[:sector_id]
        where << "sector_ids && ('{'||#{params[:sector_id].sanitize_sql!}||'}')::integer[]"
      end
      if params[:cluster_id]
        where << "cluster_ids && ('{'||#{params[:cluster_id].sanitize_sql!}||'}')::integer[]"
      end
      if params[:region_id]
        where << "regions_ids && ('{'||#{params[:region_id].sanitize_sql!}||'}')::integer[]"
      end
    end


    if params[:q].present?
      q = "%#{params[:q].sanitize_sql!}%"
      where << "(project_name ilike '#{q}' OR project_description ilike '#{q}')"
      where_facet << "(p.name ilike '#{q}' OR p.description ilike '#{q}')"
    end

    where = where.present? ? "WHERE #{where.join(' AND ')}" : ''

    sql = "select * from data_denormalization as dn
              #{where}
              order by created_at DESC
              limit #{limit} offset #{limit * (@current_page - 1)}"

    @projects = ActiveRecord::Base.connection.execute(sql)

    sql_count = "select count(*) as count from data_denormalization #{where}"
    @total_projects = ActiveRecord::Base.connection.execute(sql_count).first['count'].to_i
    @total_pages = (@total_projects.to_f / limit.to_f).ceil

    respond_to do |format|
      format.html do
        where_facet = where_facet.present? ? "WHERE #{where_facet.join(' AND ')}" : ''
        # cluster / sector Facet
        if @site.navigate_by_cluster?
          sql = "select c.id,c.name,count(pc.*) as count from clusters as c
           inner join clusters_projects as cp on c.id=cp.cluster_id
           inner join projects_sites as ps on cp.project_id=ps.project_id and ps.site_id=#{@site.id}
           inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now())
           #{where_facet}
           group by c.id,c.name order by count DESC"
          @clusters = Cluster.find_by_sql(sql).map do |c|
            [c, c.count]
          end
        else
          sql = "select s.id,s.name,count(ps.*) as count from sectors as s
           inner join projects_sectors as ps on s.id=ps.sector_id
           inner join projects_sites as psi on psi.project_id=ps.project_id and psi.site_id=#{@site.id}
           inner join projects as p on psi.project_id=p.id and (p.end_date is null OR p.end_date > now())
           #{where_facet}
           group by s.id,s.name order by count DESC"
          @sectors = Sector.find_by_sql(sql).map do |s|
            [s, s.count]
          end
        end

        sql = "select r.id, r.name ,count(ps.*) as count from regions as r
           inner join projects_regions as pr on r.id=pr.region_id and r.level=#{@site.level_for_region}
           inner join projects_sites as ps on pr.project_id=ps.project_id and ps.site_id=#{@site.id}
           inner join projects as p on ps.project_id=p.id and (p.end_date is null OR p.end_date > now()) AND (p.name ilike '#{q}' OR p.description ilike '#{q}')
           group by r.id,r.name order by count DESC"
        @regions = Region.find_by_sql(sql).map do |r|
          [r, r.count]
        end

      end
      format.js do
        render :update do |page|
          page << "$('#search_view_more').html('#{escape_javascript(render(:partial => 'search/pagination'))}');"
          page << "$('#search_results').append('#{escape_javascript(render(:partial => 'search/projects'))}');"
          page << "IOM.ajax_pagination();"
          page << "resizeColumn();"
        end
      end
    end
  end

end