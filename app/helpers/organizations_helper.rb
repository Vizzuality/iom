module OrganizationsHelper

  def projects_list_subtitle
    by = "BY #{@organization.name}"

    if @filter_by_location && @filter_by_category
      pluralize(@organization_projects_count, "#{@category_name} PROJECT", "#{@category_name} PROJECTS") + ' ' + by + " in #{@location_name}"
    elsif @filter_by_location
      pluralize(@organization_projects_count, "PROJECT", "PROJECTS") + ' ' + by + " in #{@location_name}"
    elsif @filter_by_category
      pluralize(@organization_projects_count, "#{@filter_name} PROJECT", "#{@filter_name} PROJECTS")
    else
      pluralize(@organization_projects_count, "PROJECT", "PROJECTS") + ' ' + by
    end
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
        raw("#{link_to geo.name, organization_path(@organization, :location_id => geo.to_param)} - #{count}")
      end)
    end

    lis << content_tag(:li, "Others - #{values.last}", :class => 'pos3') if projects.count > 3

    ul    = content_tag :ul, raw(lis), :class => 'chart'
    chart = image_tag "http://chart.apis.google.com/chart?cht=p&chs=120x120&chd=t:#{values.join(',')}&chds=0,#{max_value}&chco=333333|565656|727272|ADADAD|EFEFEF|FFFFFF&chf=bg,s,FFFFFF00", :class => 'pie_chart'
    [ul, chart]
  end

  def funding_percentages(organization, site)
    private_percentage = ((organization.private_funding / organization.budget(site))*100).ceil.to_i rescue 0
    usg_percentage = ((organization.usg_funding / organization.budget(site))*100).to_i rescue 0
    other_percentages = 100 - private_percentage - usg_percentage
    result = []
    result << "#{private_percentage}% private" if private_percentage > 0
    result << "#{usg_percentage}% USG" if usg_percentage > 0
    result << "#{other_percentages}% other" if other_percentages > 0
    result.join(', ')
  end

end
