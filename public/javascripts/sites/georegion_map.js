
    var map;
    var bounds;
    var overlay; 
    var map;
    var baseUrl="http://chart.apis.google.com/chart?chs=256x256";
    var global_index = 10;

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
        disableDefaultUI: true,
        zoom: 15,
        center: new google.maps.LatLng(map_data[0].lat, map_data[0].lon)
      }
      map = new google.maps.Map(document.getElementById("map"), myOptions);
      map.overlayMapTypes.insertAt(2, mapChartType);
      map.mapTypes.set('labels', styleMapType);
      map.setMapTypeId('labels');
  
  
      for (var i = 0; i<map_data.length; i++) {
        diameter = 58;
        marker_image = marker_source+'marker_6.png';
        var marker_ = new IOMMarker(map_data[i],diameter, marker_image,map);
      }
  
      var polygon = createGeoJsonPolygon(area_geojson);
      polygon.setMap(map)

  
  
      //Positionate zoom controls
      positionZoomControls();
      $('#zoomIn').fadeIn();
      $('#zoomOut').fadeIn();
      window.onResize = positionZoomControls;
  
    });


    function positionZoomControls() {
      var column_position = $('#layout').offset().left;
      var map_position = $('#map').position().top + 25;
  
      $('#zoomIn').css('left',column_position+'px');
      $('#zoomIn').css('top',map_position+'px');
  
      $('#zoomOut').css('left',column_position+32+'px');
      $('#zoomOut').css('top',map_position+'px');
    }


    function zoomIn() {
      map.setZoom(map.getZoom()+1);
    }

    function zoomOut() {
      map.setZoom(map.getZoom() - 1);
    }


    function createGeoJsonPolygon(geojson){
    	var coords = geojson.coordinates;
    	var paths = [];
    	var bounds = new google.maps.LatLngBounds();
    	$.each(coords,function(i,n){
    		$.each(n,function(j,o){
    			var path=[];
    			$.each(o,function(k,p){
    				var ll = new google.maps.LatLng(p[1],p[0]);
    				bounds.extend(ll);
    				path.push(ll);
    			});
    			paths.push(path);
    		});
    	});
    	var polygon = new google.maps.Polygon({
    		paths: paths,
    		strokeColor: area_stroke_color,
    		strokeOpacity: 1,
    		strokeWeight: 2,
    		fillColor: area_fill_color,
    		fillOpacity: 0.25
    	});
    	map.fitBounds(bounds);
    	return polygon;
    }







