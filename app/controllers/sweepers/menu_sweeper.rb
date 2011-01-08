class MenuSweeper < ActionController::Caching::Sweeper

  observe Cluster,Sector,Organization,Page,Site,Region

  def after_save(record)
    Site.select("id").all.each do |site|
      expire_fragment("#{site.id}/home/menu")
    end
  end

  def after_destroy(record)
    Site.select("id").all.each do |site|
      expire_fragment("#{site.id}/home/menu")
    end
  end
end