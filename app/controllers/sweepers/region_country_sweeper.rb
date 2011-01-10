class RegionCountrySweeper < ActionController::Caching::Sweeper

  observe Region,Country

  def after_save(record)
    Site.select("id").all.each do |site|
      expire_fragment("#{site.id}/home/menu")
      expire_fragment("#{site.id}/home/projects_by_location")
    end
  end

  def after_destroy(record)
    Site.select("id").all.each do |site|
      expire_fragment("#{site.id}/home/menu")
      expire_fragment("#{site.id}/home/projects_by_location")
    end
  end
end