class PageSweeper < ActionController::Caching::Sweeper

  observe Page

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