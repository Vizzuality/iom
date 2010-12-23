module SearchHelper
  def filter_url(model)
    url_options = {
      :q          => params[:q]
    }
    url_options[:region_id]  = params[:region_id]  if params[:region_id].present?
    url_options[:cluster_id] = params[:cluster_id] if params[:cluster_id].present?
    url_options["#{model.class.name.downcase}_id".to_sym] = model.id

    search_path(url_options)
  end

  def remove_filter_url(key)
    url_options = {
      :q          => params[:q]
    }
    url_options[:region_id]  = params[:region_id]  if params[:region_id].present?
    url_options[:cluster_id] = params[:cluster_id] if params[:cluster_id].present?

    url_options.delete(key)

    search_path(url_options)
  end

  def active_facets
    active_facets = ''
    if params[:cluster_id]
      cluster = @clusters.map{|c| c.first}.select{|c| c.id == params[:cluster_id].to_i}.first
      active_facets << "in #{link_to(cluster.name, remove_filter_url(:cluster_id))} CLUSTER"
    end
    if params[:region_id]
      region = @regions.map{|r| r.first}.select{|r| r.id == params[:region_id].to_i}.first
      active_facets << "in region #{link_to(region.name, remove_filter_url(:region_id))}"
    end
    raw(active_facets)
  end
end