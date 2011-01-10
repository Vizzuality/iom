class SiteSweeper < ActionController::Caching::Sweeper

  observe Site

  def after_save(record)
    Site.select("id").all.each do |site|
      expire_fragment("#{site.id}/home/menu")
      expire_fragment("#{site.id}/home/projects_by_location")
      expire_fragment("#{site.id}/home/projects_by_cluster_sector")
      expire_fragment("#{site.id}/home/organizations")
    end
  end

  def after_destroy(record)
    Site.select("id").all.each do |site|
      expire_fragment("#{site.id}/home/menu")
      expire_fragment("#{site.id}/home/projects_by_location")
      expire_fragment("#{site.id}/home/projects_by_cluster_sector")
      expire_fragment("#{site.id}/home/organizations")
    end
  end
end