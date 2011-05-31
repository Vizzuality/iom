class SearchController < ApplicationController

  layout 'site_layout'

  def index
    where  = ["is_active=true","site_id=#{@site.id}"]
    limit = 20
    @current_page = params[:page] ? params[:page].to_i : 1
    @clusters = @regions = @filtered_regions = @filtered_sectors = @filtered_clusters = @filtered_organizations = @filtered_donors = []
    @navigate_by_cluster = @site.navigate_by_cluster?

    if params[:regions_ids].present?
      @filtered_regions = Region.find_by_sql("select r.id, r.name as title, c.name as subtitle from regions as r inner join countries as c on c.id = r.country_id where r.id in (#{params[:regions_ids].sanitize_sql!})")
      filtered_regions_where = "where r.id not in (#{params[:regions_ids].sanitize_sql!})"
      params[:regions_ids].split(',').each do |region_id|
        where << "regions_ids && ('{'||#{region_id.sanitize_sql!}||'}')::integer[]"
      end
    end

    if params[:sectors_ids].present?
      @filtered_sectors = Sector.find_by_sql("select s.id, s.name as title from sectors as s where s.id in (#{params[:sectors_ids].sanitize_sql!})")
      filtered_sectors_where = "where s.id not in (#{params[:sectors_ids].sanitize_sql!})"
      params[:sectors_ids].split(',').each do |sector_id|
        where << "sector_ids && ('{'||#{sector_id.sanitize_sql!}||'}')::integer[]"
      end
    end

    if params[:clusters_ids].present?
      @filtered_clusters = Cluster.find_by_sql("select c.id, c.name as title from clusters as c where c.id in (#{params[:clusters_ids].sanitize_sql!})")
      filtered_clusters_where = "where c.id not in (#{params[:clusters_ids].sanitize_sql!})"
      params[:clusters_ids].split(',').each do |cluster_id|
        where << "cluster_ids && ('{'||#{cluster_id.sanitize_sql!}||'}')::integer[]"
      end
    end

    if params[:organizations_ids].present?
      @filtered_organizations = Cluster.find_by_sql("select o.id, o.name as title from organizations as o where o.id in (#{params[:organizations_ids].sanitize_sql!})")
      filtered_organizations_where = "where o.id not in (#{params[:organizations_ids].sanitize_sql!})"
      where << "organization_id IN (#{params[:organizations_ids].sanitize_sql!})"
    end

    if params[:donors_ids].present?
      @filtered_donors = Donor.find_by_sql("select d.id, d.name as title from donors as d where d.id in (#{params[:donors_ids].sanitize_sql!})")
      filtered_donors_where = "where d.id not in (#{params[:donors_ids].sanitize_sql!})"
      params[:donors_ids].split(',').each do |donor_id|
        where << "donors_ids && ('{'||#{donor_id.sanitize_sql!}||'}')::integer[]"
      end
    end

    if params[:q].present?
      q = "%#{params[:q].sanitize_sql!}%"
      where << "(project_name ilike '#{q}' OR
                 project_description ilike '#{q}' OR
                 organization_name ilike '#{q}' OR
                 sectors ilike '#{q}' OR
                 regions ilike '#{q}' )"
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

    #TODO: I am not taking in consideration the search on organization and location when using the facets.

    respond_to do |format|
      format.html do
        # cluster / sector Facet
        if @site.navigate_by_cluster?
          sql = <<-SQL
            SELECT DISTINCT c.id,c.name AS title
            FROM clusters AS c
            INNER JOIN clusters_projects AS cp ON c.id=cp.cluster_id
            INNER JOIN projects_sites AS ps ON cp.project_id=ps.project_id AND ps.site_id=#{@site.id}
            INNER JOIN projects AS p ON ps.project_id=p.id AND (p.end_date is NULL OR p.end_date > now())
            #{filtered_clusters_where}
          SQL
          @clusters = Cluster.find_by_sql(sql)
        else
          sql = <<-SQL
            SELECT DISTINCT s.id,s.name AS title
            FROM sectors AS s
            INNER JOIN projects_sectors AS ps ON s.id=ps.sector_id
            INNER JOIN projects_sites AS psi ON psi.project_id=ps.project_id AND psi.site_id=#{@site.id}
            INNER JOIN projects AS p ON psi.project_id=p.id AND (p.end_date is NULL OR p.end_date > now())
            #{filtered_sectors_where}
          SQL
          @sectors = Sector.find_by_sql(sql)
        end

        sql = <<-SQL
          SELECT DISTINCT r.id, r.name AS title, c.name AS subtitle
          FROM regions AS r
          INNER JOIN projects_regions AS pr ON r.id=pr.region_id AND r.level=#{@site.level_for_region}
          INNER JOIN projects_sites AS ps ON pr.project_id=ps.project_id AND ps.site_id=#{@site.id}
          INNER JOIN projects AS p ON ps.project_id=p.id AND (p.end_date is NULL OR p.end_date > now()) AND (p.name ilike '#{q}' OR p.description ilike '#{q}')
          INNER JOIN countries AS c ON c.id = r.country_id
          #{filtered_regions_where}
        SQL
        @regions = Region.find_by_sql(sql)

        sql = <<-SQL
          SELECT DISTINCT o.id, o.name AS title
          FROM organizations AS o
          INNER JOIN projects AS p ON (p.end_date is NULL OR p.end_date > now()) AND (p.name ilike '#{q}' OR p.description ilike '#{q}') AND p.primary_organization_id = o.id
          INNER JOIN projects_sites AS ps ON ps.project_id = p.id AND ps.site_id = #{@site.id}
          #{filtered_organizations_where}
        SQL
        @organizations = Organization.find_by_sql(sql)

        sql = <<-SQL
          SELECT DISTINCT d.id, d.name AS title
          FROM donors AS d
          INNER JOIN projects AS p ON (p.end_date is NULL OR p.end_date > now()) AND (p.name ilike '#{q}' OR p.description ilike '#{q}')
          INNER JOIN projects_sites AS ps ON ps.project_id = p.id AND ps.site_id = #{@site.id}
          INNER JOIN donations AS dn ON dn.donor_id = d.id AND dn.project_id = p.id
          #{filtered_donors_where}
        SQL
        @donors = Donor.find_by_sql(sql)

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