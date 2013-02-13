module UsersHelper

  def user_organization_name(user)
    return 'in Interaction' if user.organization.blank?

    organization_name           = user.organization.name
    organization_name_truncated = truncate(organization_name, :length => 45)
    organization_link           = edit_admin_organization_path(user.organization)

    raw("in #{link_to organization_name_truncated, organization_link, :title => organization_name}")
  end

end
