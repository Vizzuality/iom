module OrganizationsHelper

  def funding_percentages(organization)
    private_percentage = ((organization.private_funding / organization.budget)*100).ceil.to_i rescue 0
    usg_percentage = ((organization.usg_funding / organization.budget)*100).to_i rescue 0
    other_percentages = 100 - private_percentage - usg_percentage
    result = []
    result << "#{private_percentage}% private" if private_percentage > 0
    result << "#{usg_percentage}% USG" if usg_percentage > 0
    result << "#{other_percentages}% other" if other_percentages > 0
    result.join(', ')
  end

end
