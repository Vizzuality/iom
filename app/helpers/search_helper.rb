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
end