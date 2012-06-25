xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do

  xml.channel do

    xml.title @site.name
    xml.description @site.short_description
    xml.link "#{url(@site)}/.xml"

    for item in @rss_items
      xml.item do
        xml.title item['project_name']
        xml.description item['project_description']
        xml.pubDate Date.parse(item['created_at']).to_s(:rfc822)
        xml.link project_url(item['project_id'])
        xml.guid item.id
      end
    end

  end

end
