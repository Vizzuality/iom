class OrganizationSweeper < ActionController::Caching::Sweeper

  observe Organization

  def after_save(record)
    Site.select("id").all.each do |site|
      expire_fragment("#{site.id}/home/menu")
      expire_fragment("#{site.id}/home/organizations")
    end
  end

  def after_destroy(record)
    Site.select("id").all.each do |site|
      expire_fragment("#{site.id}/home/menu")
      expire_fragment("#{site.id}/home/organizations")
    end
  end
end