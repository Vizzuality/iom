module ApplicationHelper

  def selected_if_current_page(url_path, extra_condition = false)
    if @organization || @pages || @donor
      if (action_name == "specific_information" || action_name == 'new' || action_name == 'edit' || action_name == 'create' || action_name == 'update' || action_name == "index")
        if request.path == url_path || extra_condition
          raw("class=\"list_selected\"")
        else
          raw("class=\"list_unselected\"")
        end
      else
        raw("class=\"selected\"") if request.path == url_path
      end
    elsif @page
      if %w(edit update).include?(action_name) && controller_name == 'pages'
        raw("class=\"sublist_selected\"") if request.path.match(url_path)
      end
    else
      raw("class=\"selected\"") if request.path == url_path
    end
  end

  def show_sites?
    (@organization || @donor) && ((controller_name == 'organizations' || controller_name == 'donors') && (action_name == "specific_information" || action_name == 'edit' || action_name == 'create' || action_name == 'update'))
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

  def errors_for_span(obj, attribute)
    return if action_name == 'new'
    unless obj.errors[attribute].empty?
      return raw(<<-HTML
<span class="simple_field_error">
  <a class="simple_error"></a>
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
    if @data
      result << @data.name
    end
    if @donor
      result << @donor.name.html_safe
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
    if @area
      result << @area.name
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

  def cluster_sector_width(count, max = 203)
    if count >= max
      203
    elsif count < 0
      0
    else
      count * 203 / max
    end
  end

  def url(site)
    if site.url =~ /^http/
      site.url
    else
      "http://#{site.url}"
    end + (Rails.env == 'development' ? ":#{request.port}" : '')
  end

  def projects_by_location(site, collection = nil)
    projects = collection
    projects ||= if site.world_wide_context?
      site.projects_countries
    else
      site.projects_regions
    end
    counts    = projects.map{ |geo| geo.last}
    values    = counts.slice!(0, 3) + [counts.inject( nil ) { |sum,x| sum ? sum + x : x }]
    values.compact!
    max_value = values.max
    lis       = []

    projects[0..2].each_with_index do |geo_entries, index|
      geo = geo_entries.first
      count  = geo_entries.last
      lis << (content_tag :li,  :class => "pos#{index}" do
        case controller_name
        when 'organizations'
          raw("#{link_to geo.name, organization_path(@organization, :location_id => geo.to_param)} - #{count}")
        when 'clusters_sectors'
          if site.navigate_by_cluster?
            raw("#{link_to geo.name, cluster_path(@data, :location_id => geo.to_param)} - #{count}")
          else
            raw("#{link_to geo.name, sector_path(@data, :location_id => geo.to_param)} - #{count}")
          end
        when 'georegion'
          raw("#{link_to geo.name, location_path(@area, :location_id => geo.to_param)} - #{count}")
        else
          raw("#{link_to geo.name, location_path(geo)} - #{count}")
        end
      end)
    end

    lis << content_tag(:li, "Others - #{values.last}", :class => 'pos3') if projects.count > 3

    ul    = content_tag :ul, raw(lis), :class => 'chart'
    chart = image_tag "http://chart.apis.google.com/chart?cht=p&chs=120x120&chd=t:#{values.join(',')}&chds=0,#{max_value}&chco=333333|565656|727272|ADADAD|EFEFEF|FFFFFF&chf=bg,s,FFFFFF00", :class => 'pie_chart'
    [ul, chart]
  end

  def anglo(text)
    return "" if text.blank?
    text.gsub(/(\d+\.[\d+\.?\d+]+)/) do |n|
      n.gsub(/\./,",")
    end
  end

  def pagination_params
    params.merge(:page => @projects.current_page + 1, :start_in_page => @projects.start_in_page)
  end

  def word_for_geo_context(area)
    area.is_a?(Region) ? @site.word_for_regions.singularize : 'Country'
  end

end
