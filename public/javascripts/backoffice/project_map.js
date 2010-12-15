
    var markers_position = [];
    var map;
    var geocoder = new google.maps.Geocoder();
    var first = true;

    $(document).ready( function() {
      
      //change geolocate input value
      $('div.outer_map form input[type="text"]').focusin(function(ev){
        if ($(this).attr('value')=="Location, latitude or longitude") {
          $(this).attr('value','');
        }
      });
      $('div.outer_map form input[type="text"]').focusout(function(ev){
        if ($(this).attr('value')=="") {
          $(this).attr('value','Location, latitude or longitude');
        }
      });
      
      
      $('a#add_location_map').click(function(ev){
        ev.preventDefault();
        ev.stopPropagation();
        var position = $(this).offset();
        $('div.map_window').css('top',position.top-310+'px');
        $('div.map_window').css('left',position.left-140+'px');
        $('div.map_window').fadeIn(function(){
          if (first) {
            first = false;
            var myOptions = {
              zoom: 1,
              center: new google.maps.LatLng(30, 0),
              disableDefaultUI: true,
              mapTypeId: google.maps.MapTypeId.ROADMAP
            }
            map = new google.maps.Map(document.getElementById("map"),myOptions);

            google.maps.event.addListener(map,"click",function(event){
      				var image = new google.maps.MarkerImage('/images/backoffice/projects/project_marker.png',new google.maps.Size(34, 42),new google.maps.Point(0,0),	new google.maps.Point(17, 42));
      				var marker = new google.maps.Marker({position: event.latLng,  map:map, icon:image});
      				markers_position.push(event.latLng);
      			});
          }
        });

        
        $(window).resize(function() {
          var position = $('a#add_location_map').position();
          $('div.map_window').css('top',position.top+'px');
          $('div.map_window').css('left',position.left+'px');
        });
      });
      
      $('a.close').click(function(){
        $(window).unbind('resize');
        $('div.map_window').fadeOut();
      });
      
      
      
    });
    
    
    function searchPlace() {
		  var address = $('div.outer_map form input[type="text"]').attr('value');
      geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          map.setCenter(results[0].geometry.location);
          map.fitBounds(results[0].geometry.bounds);
        }
      });
		}