module Admin::SitesHelper
  def selected_if_worldwide(site)
    'selected' unless %w(country_id region_id geometry).select{|m| site.send("geographic_context_#{m}").present?}.length > 0
  end

  def selected_if_field_present(model, field)
    'selected' if model.send(field)
  end
end
