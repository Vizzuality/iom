
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
        zoom: 9,
        center: new google.maps.LatLng(map_data[0].lat, map_data[0].lon)
      }
      map = new google.maps.Map(document.getElementById("map"), myOptions);
      //map.overlayMapTypes.insertAt(2, mapChartType);
      map.mapTypes.set('labels', styleMapType);
      map.setMapTypeId('labels');
  
  
      for (var i = 0; i<map_data.length; i++) {
        diameter = 58;
        marker_image = marker_source+'marker_6.png';
        var marker_ = new IOMMarker(map_data[i],diameter, marker_image,map);
      }
  
      //var polygon = createGeoJsonPolygon(area_geojson);
      //polygon.setMap(map)
  
  
      //Positionate controls
      setTimeout(function(){
        positionControls();
        $('#zoomIn').fadeIn();
        $('#zoomOut').fadeIn();
      },500);
      
      $('#zoomIn,#zoomOut').click(function(ev){
        ev.preventDefault();
        ev.stopPropagation();
      });
      
      $('div.map_style').click(function(){
        if ($('div.map_style').height()==76) {
          $('div.map_style').css('background-position','0 0');
          $('div.map_style').height(26);
        } else {
          $('div.map_style').css('background-position','0 -26px');
          $('div.map_style').height(76);
        }
      });

      $('div.map_style ul li a').click(function(ev){
        ev.preventDefault();
        ev.stopPropagation();
        if ($(this).text()!=$('div.map_style').text()) {
          if ($(this).text()=="PLAIN") {
            map.setMapTypeId('labels');
          } else {
            map.setMapTypeId(google.maps.MapTypeId.SATELLITE);
          }
          $('div.map_style p').text($(this).text());
        }
        $('div.map_style').css('background-position','0 0');
        $('div.map_style').height(26);
      });

      $('div.map_style').fadeIn();
      
      
      $(window).resize(function(){
        positionControls();
      });
  
    });


    function positionControls() {
      if ($('#layout').length>0) {
        var column_position = $('#layout').offset().left;
        var map_position = $('#map').position().top + 25;
      } else {
        var column_position = $('#mesh').offset().left + 5;
        var map_position = $('#small_map').position().top + 25;
      }

      $('#zoomIn').css('left',column_position+'px');
      $('#zoomIn').css('top',map_position+'px');

      $('#zoomOut').css('left',column_position+32+'px');
      $('#zoomOut').css('top',map_position+'px');

      $('div.map_style').css('left',column_position+821+'px');
      $('div.map_style').css('top',map_position+'px');
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







