xml.channel do
  xml.atom :link, nil, {
    :href => root_url(:format => 'rss'),
    :rel => 'self', :type => 'application/rss+xml'
  }

  xml.title @site.name
  xml.description @site.short_description
  xml.link root_url(:format => 'rss')

  for item in @rss_items
    xml.item do
      xml.title item.name
      xml.description item.description
      xml.pubDate item.updated_at.to_s(:rfc822)
      xml.link project_url(item)
      xml.guid item.id
    end
  end
end
