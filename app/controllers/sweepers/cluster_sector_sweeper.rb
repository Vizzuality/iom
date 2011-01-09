class ClusterSectorSweeper < ActionController::Caching::Sweeper

  observe Cluster,Sector

  def after_save(record)
    Site.select("id").all.each do |site|
      expire_fragment("#{site.id}/home/menu")
      expire_fragment("#{site.id}/home/projects_by_cluster_sector")
    end
  end

  def after_destroy(record)
    Site.select("id").all.each do |site|
      expire_fragment("#{site.id}/home/menu")
      expire_fragment("#{site.id}/home/projects_by_cluster_sector")
    end
  end
end