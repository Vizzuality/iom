module Admin::SitesHelper
  def selected_if_worldwide(site)
    'selected' unless %w(country_id region_id geometry).select{|m| site.send("geographic_context_#{m}").present?}.length > 0
  end

  def selected_if_field_present(model, field)
    'selected' if model.send(field)
  end

  def edit_or_customize_site
    partial = if controller_name == 'partners'
      'admin/sites/form_customization'
    elsif action_name == 'edit' || action_name == 'update' || action_name == 'create'
      'admin/sites/form'
    else
      'admin/sites/form_customization'
    end
    render :partial => partial
  end
end
