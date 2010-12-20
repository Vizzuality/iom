   
   var map;
   var bounds = new google.maps.LatLngBounds();
   
   var overlay; 
   var map;
   var baseUrl="http://chart.apis.google.com/chart?chs=256x256";

   var chco = "F7F7F7,8BC856,336600";
   var chf = "bg,s,2F84A3";
   var chld = "HT-AR|HT-CE|HT-GR|HT-NI|HT-ND|HT-NE|HT-OU|HT-SD|HT-SE";
   var chd = "t:0,10,20,30,40,50,60,70,80";    

   var stylez= [
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
         { visibility: "off" }
       ]
     },{
       featureType: "administrative.province",
       elementType: "all",
       stylers: [
         { visibility: "off" }
       ]
     },{
       featureType: "administrative.neighborhood",
       elementType: "all",
       stylers: [
         { visibility: "off" }
       ]
     },{
       featureType: "administrative.land_parcel",
       elementType: "all",
       stylers: [
         { visibility: "off" }
       ]
     }
   ];
   var styledMapOptions = {name: "labels"};



    $(document).ready( function() {
      
      //If description is bigger than main_head
      if ($('div.inner_main_head div.right').height()>$('div.inner_main_head div.left').height()) {
        $('div.inner_main_head div.left').height($('div.inner_main_head div.right').height());
        $('div.inner_main_head div.float_head').height($('div.inner_main_head div.right').height());
      }
      
      
      //If right part is bigger than float left
      $('div#left_column div.outer_float').height($('div#left_column div.float_left').height()-40);
      
      if ($('div#left_column div.float_left').height() < $('div#left_column div.right').height()) {
        var offset =  $('div#left_column div.right').height() - $('div#left_column div.float_left').height() + 120;
        if ($('div.block.green').is(':visible')) {
          $('div#left_column div.float_left').append('<div class="block"></div>');
          $('div#left_column div.float_left div.block:last').height(offset);
        } else {
          $('div#left_column div.float_left div.block:last').height(offset);
        }
      }
      
      if ($('div#left_column div.float_left').height() > $('div#left_column div.left').height()) {
        $('div#left_column div.left').height($('div#left_column div.float_left').height());
      }
      

      
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

      try {
        for (var i = 0; i<map_data._data.length; i++) {
          var marker_ = new IOMMarker(map_data._data[i],map_data.theme,map);
          bounds.extend(new google.maps.LatLng(map_data._data[i].lat,map_data._data[i].lon));
        }
        map.setCenter(bounds.getCenter());
        map.setZoom(8);
      } catch (e) {}


      
      
      if ($('#secondary_map').length > 0){
          var map2 = new google.maps.Map(document.getElementById("secondary_map"),myOptions);
          map2.setCenter(new google.maps.LatLng(40.42245660632275, -3.699495792388916));
          map2.setZoom(17);
      }
    });