module Admin::ActivitiesHelper

  def url_for_user_organization(organization)
    edit_admin_organization_path(organization) rescue '/admin'
  end

  def changes_for(values)
    html = []
    case values.first
    when Array
      values.first.flatten.each do |hash|
        html << content_tag(:div, :class => 'from') do
          raw [
            content_tag(:p, hash.keys.first, :class => 'label'),
            content_tag(:p, extract(hash.values.first), :class => 'value')
          ].join
        end
      end
    else
      html << content_tag(:div, :class => 'from') do
        raw [
          content_tag(:p, 'from', :class => 'label'),
          content_tag(:p, extract(values.first), :class => 'value')
        ].join
      end
      html << content_tag(:div, :class => 'to') do
        raw [
          content_tag(:p, 'to', :class => 'label'),
          content_tag(:p, extract(values.last), :class => 'value')
        ].join
      end
    end

    raw html
  end

  def extract(value)
    case value
    when Hash
      return "#{value['geometries'][0]['y']}, #{value['geometries'][0]['x']}" if value.has_key?('geometries')
      return value['deleted'] if value.has_key?('deleted')
      return value['new'] if value.has_key?('new')
    when Date
      localize value, :format => '%m/%d/%Y'
    else
      value
    end
  end
end
