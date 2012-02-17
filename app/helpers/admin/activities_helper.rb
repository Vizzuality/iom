module Admin::ActivitiesHelper

  def url_for_user_organization(organization)
    edit_admin_organization_path(organization) rescue '/admin'
  end

  def changes_for(values)
    html = []
    case values.first
    when Array
      values.first.each do |key, value|
        html << content_tag(:div, :class => 'from') do
          raw [
            content_tag(:p, key, :class => 'label'),
            content_tag(:p, value, :class => 'value')
          ].join
        end
      end
    else
      html << content_tag(:div, :class => 'from') do
        raw [
          content_tag(:p, 'from', :class => 'label'),
          content_tag(:p, values.first, :class => 'value')
        ].join
      end
      html << content_tag(:div, :class => 'to') do
        raw [
          content_tag(:p, 'to', :class => 'label'),
          content_tag(:p, values.last, :class => 'value')
        ].join
      end
    end

    raw html
  end

end
