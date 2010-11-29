
    var map;
    var first = true;
		var selection_polygon;
		var drawing = false;

    $(document).ready( function() {
      $('#gc_limited_bbox a').click(function(ev){
        if (first) {
          first = false;
          var myOptions = {
            zoom: 4,
            center: new google.maps.LatLng(18.971187, -72.285215),
            disableDefaultUI: true,
            navigationControl: true,
            navigationControlOptions: {
             style: google.maps.NavigationControlStyle.SMALL
            },
            mapTypeId: google.maps.MapTypeId.ROADMAP
          }
          map = new google.maps.Map(document.getElementById("map_bbox"),myOptions);

          selection_polygon = new google.maps.Polygon({
  		      strokeColor: "#FF6600",
  		      strokeOpacity: 1,
  		      strokeWeight: 1,
  		      fillColor: "#FF6600",
  		      fillOpacity: 0
  		    });
          google.maps.event.addListener(map,"click",function(event){
            changeMapSelectionStatus(event.latLng);
          });
        }
      });
    });
    
    
    
    function changeMapSelectionStatus(latlng) {			
			if (selection_polygon.getPath().getLength()==0 || !drawing) {
				selection_polygon.setOptions({fillOpacity: 0});
				drawing = true;
				selection_polygon.setPath([latlng,latlng,latlng,latlng]);
				selection_polygon.setMap(map);
				google.maps.event.clearListeners(selection_polygon, 'mouseover');
				google.maps.event.clearListeners(selection_polygon, 'mouseout');
				google.maps.event.addListener(map,"mousemove",function(event){
					if (selection_polygon.getPath().getLength()!=0) {
						selection_polygon.setPath([
							selection_polygon.getPath().getAt(0),
							new google.maps.LatLng(selection_polygon.getPath().getAt(0).lat(),event.latLng.lng()),
							event.latLng,
							new google.maps.LatLng(event.latLng.lat(),selection_polygon.getPath().getAt(0).lng()),
							selection_polygon.getPath().getAt(0)]);
					}
				});
				google.maps.event.addListener(selection_polygon,'click',function(evt){
					drawing = false;
					selection_polygon.setOptions({fillOpacity: 0.40});
				  google.maps.event.clearListeners(map, 'mousemove');
					google.maps.event.clearListeners(selection_polygon, 'click');
				});
			} else {
				if (drawing) {
					drawing = false;
					selection_polygon.setOptions({fillOpacity: 0.40});
				  google.maps.event.clearListeners(map, 'mousemove');
					google.maps.event.clearListeners(selection_polygon, 'click');
				}
			}
		}
