  var mapChartType;
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
    mapChartType = new google.maps.ImageMapType(mapChartOptions);      
    
    bounds =new google.maps.LatLngBounds(
      new google.maps.LatLng(bbox[0].lat,bbox[0].lon),
      new google.maps.LatLng(bbox[1].lat,bbox[1].lon)
      ); 

    var myOptions = {
      scrollwheel: false,
      mapTypeControl: false,
      streetViewControl: false,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      disableDefaultUI: true,
      zoom: 2,
      center: bounds.getCenter()
    }
    if ($('#map').length>0) {
      map = new google.maps.Map(document.getElementById("map"), myOptions);
    } else {
      map = new google.maps.Map(document.getElementById("small_map"), myOptions);
    }
    map.overlayMapTypes.insertAt(2, mapChartType);
    map.mapTypes.set('labels', styleMapType);
    map.setMapTypeId('labels');
    
    google.maps.event.addListener(map, "zoom_changed", function() {
        if (map.getZoom() > 12) map.setZoom(12);
    });
    
    if (map_type == "overview_map") {
      var range = max_count/3;
    }
    var diameter = 0;
    
    for (var i = 0; i<map_data.length; i++) {
      var image_source = '';
      
      if (map_type == "overview_map") {
        if (map_data[i].count <range) {
          diameter = 34;
          image_source = "/images/themes/"+ theme + '/marker_4.png';
        } else if ((map_data[i].count>=(range)) && (map_data[i].count<(range*2))) {
          diameter = 42;
          image_source = "/images/themes/"+ theme + '/marker_5.png';
        } else {
          diameter = 58;
          image_source = "/images/themes/"+ theme + '/marker_6.png';
        }
      } else {
        diameter = 72;
        image_source = "/images/themes/"+ theme + '/project_marker.png';
      }
      var marker_ = new IOMMarker(map_data[i],diameter, image_source,map);
    }
    

    map.fitBounds(bounds);
    
    if (map_type=="overview_map") {
      setTimeout(function(){zoomIn()},200);
    }
    
    //Positionate zoom controls
    positionControls();
    $('#zoomIn').fadeIn();
    $('#zoomOut').fadeIn();
    
    $('div.map_style').hover(function(){
      $('div.map_style').css('background-position','0 -26px');
      $('div.map_style').height(76);
    },function(){
      $('div.map_style').css('background-position','0 0');
      $('div.map_style').height(26);
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
    });
    
    
    $('div.map_style').fadeIn();
    
    $(window).resize(function() {
      positionZoomControls();
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
    
    $('div.map_style').css('left',column_position+820+'px');
    $('div.map_style').css('top',map_position+'px');
  }
  
  
  function zoomIn() {
    var zoom = map.getZoom();
    if (zoom<12) {
      map.setZoom(zoom+1);
    }
  }
  
  function zoomOut() {
    map.setZoom(map.getZoom() - 1);
  }