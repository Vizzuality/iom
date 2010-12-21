
  var map;
  var bounds = new google.maps.LatLngBounds();
  var overlay; 
  var map;
  var baseUrl="http://chart.apis.google.com/chart?chs=256x256";


  $(document).ready( function() {
    var styleMapType = new google.maps.StyledMapType(stylez, styledMapOptions);    

    var mapChartOptions = {
        getTileUrl: function(coord, zoom) {
            var lULP = new google.maps.Point(coord.x*256,(coord.y+1)*256);
            var lLRP = new google.maps.Point((coord.x+1)*256,coord.y*256);     
            var projectionMap = new MercatorProjection();
            var lULg = projectionMap.fromDivPixelToLatLng(lULP, zoom);
            var lLRg = projectionMap.fromDivPixelToLatLng(lLRP, zoom);                 
            return baseUrl+"&chd="+chd+"&chco="+chco+"&chld="+chld+"&chf="+chf+"&cht=map:fixed="+
               lULg.lat() +","+ lULg.lng() + "," + lLRg.lat() + "," + lLRg.lng();
        },
        tileSize: new google.maps.Size(256, 256),
        opacity:parseFloat(0.4),
        isPng: true
    };
    var mapChartType = new google.maps.ImageMapType(mapChartOptions);      

    var myOptions = {
      scrollwheel: false,
      mapTypeControl: false,
      streetViewControl: false,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      zoom: 8,
      center: new google.maps.LatLng(18.93205126204314, -72.6361083984375)
    }
    map = new google.maps.Map(document.getElementById("map"), myOptions);
    map.overlayMapTypes.insertAt(2, mapChartType);
    map.mapTypes.set('labels', styleMapType);
    map.setMapTypeId('labels');



    for (var i = 0; i<map_data.length; i++) {
      var marker_ = new IOMMarker(map_data[i],'#000000',map);
      bounds.extend(new google.maps.LatLng(map_data[i].lat,map_data[i].lon));
    }
    map.setCenter(bounds.getCenter());
    map.setZoom(8);
    
  });