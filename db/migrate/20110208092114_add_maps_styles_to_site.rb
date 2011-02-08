class AddMapsStylesToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :map_styles, :text

    style = <<-JSON
    [
      {
        featureType: "landscape",
        elementType: "all",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "poi",
        elementType: "all",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "road",
        elementType: "all",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "transit",
        elementType: "all",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "water",
        elementType: "all",
        stylers: [
          { hue: "#00c3ff" }
        ]
      },{
        featureType: "landscape.natural",
        elementType: "all",
        stylers: [
          { visibility: "off" },
          { hue: "#ffff00" }
        ]
      }
    ];
JSON
    Site.all.each do |site|
      site.update_attribute(:map_styles, style)
    end
  end

  def self.down
    remove_column :sites, :map_styles
  end
end
