module ApplicationHelper

  def selected_if_current_page(url_path)
    if @organization
      if (action_name == "specific_information" || action_name == 'new' || action_name == 'edit' || action_name == 'create' || action_name == 'update')
        if request.path == url_path
          raw("class=\"list_selected\"")
        else
          raw("class=\"list_unselected\"")
        end
      else
        raw("class=\"selected\"") if request.path == url_path
      end
    else
      raw("class=\"selected\"") if request.path == url_path
    end
  end

  def errors_for(obj, attribute)
    return if action_name == 'new'
    unless obj.errors[attribute].empty?
      return raw(<<-HTML
          <span class="field_error">
            <a class="error"></a>
            <div class="error_msg">
              <p><span>#{obj.errors[attribute]}</span></p>
            </div>
          </span>
      HTML
)
    end
  end

  def title
    result = []
    if @site
      result << @site.name
    else
      result << "IOM"
    end
    if @organization
      result << @organization.name
    end
    if @page
      result << @page.title
    end
    if @cluster
      result << @cluster.name
    end
    if @donor
      result << @donor.name
    end
    if @project
      result << @project.name
    end
    if @region
      result << @region.name
    end
    if @country
      result << @country.name
    end
    if controller_name == 'search' && action_name == 'index'
      if params[:q].blank?
        result << "Search"
      else
        result << "Search results for '#{params[:q]}'"
      end
    end
    return result.reverse.join(" - ")
  end

  def cluster_width(count)
    count = count*10
    if count > 203
      203
    elsif count < 0
      0
    else
      count
    end
  end

  # TODO: get real classes
  def cluster_class(cluster)
    %W{ drop plus }[rand(2)-1]
  end

end

