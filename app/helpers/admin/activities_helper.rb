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
            content_tag(:span, key, :class => 'label'),
            content_tag(:span, value)
          ].join
        end
      end
    else
      html << content_tag(:div, :class => 'from') do
        raw [
          content_tag(:span, 'from', :class => 'label'),
          content_tag(:span, values.first)
        ].join
      end
      html << content_tag(:div, :class => 'to') do
        raw [
          content_tag(:span, 'to', :class => 'label'),
          content_tag(:span, values.last)
        ].join
      end
    end

    raw html
  end

end
