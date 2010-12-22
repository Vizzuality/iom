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
      if action_name == 'edit' && controller_name == 'pages'
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

  def url(site)
    if site.url =~ /^http/
      site.url
    else
      "http://#{site.url}"
    end + (Rails.env == 'development' ? ":#{request.port}" : '')
  end

  def projects_by_location(projects)
    counts    = projects.map{|region| region.last}
    values    = counts.slice!(0, 3) + [counts.inject( nil ) { |sum,x| sum ? sum + x : x }]
    values.compact!
    max_value = values.max
    lis       = []

    projects[0..2].each_with_index do |project_region, index|
      region = project_region.first
      count  = project_region.last
      lis << (content_tag :li,  :class => "pos#{index}" do
        "#{link_to truncate(region.name, :length => 15, :omission => '...'), region_path(region)} - #{count}"
      end)
    end

    lis << content_tag(:li, "Others - #{values.last}", :class => 'pos3') if projects.count > 3

    ul    = content_tag :ul, raw(lis), :class => 'chart'
    chart = image_tag "http://chart.apis.google.com/chart?cht=p&chs=120x120&chd=t:#{values.join(',')}&chds=0,#{max_value}&chco=333333|565656|727272|ADADAD|EFEFEF|FFFFFF&chf=bg,s,FFFFFF00", :class => 'pie_chart'
    [ul, chart]
  end

end

