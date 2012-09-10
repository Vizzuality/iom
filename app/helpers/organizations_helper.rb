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

  def donation_information?(organization)
     donation_address?(organization) || donation_phone?(organization)
  end

  def donation_address?(organization)
    organization.donation_address.present? && organization.city.present? && organization.state.present? && organization.zip_code.present?
  end

  def donation_phone?(organization)
    organization.donation_phone_number.present? && organization.donation_website.present?
  end

end
