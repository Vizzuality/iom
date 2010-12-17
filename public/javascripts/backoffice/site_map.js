    var map;
    var first = true;
    var selection_polygon;
    var drawing = false;
    var polygon_path_coords = [];

    $(function(){
      var bbox_coords = $('input#site_geographic_boundary_box').val();
      if (bbox_coords) {
        createMap(bbox_coords);
      };

      $('li#gc_limited_bbox a.limited').click(createMap);
    });

    var createMap = function(bbox_coords){
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
        };
        map = new google.maps.Map(document.getElementById("map_bbox"),myOptions);
        
        selection_polygon = new google.maps.Polygon({
          strokeColor: "#FF6600",
          strokeOpacity: 1,
          strokeWeight: 1,
          fillColor: "#FF6600",
          fillOpacity: 0
        });

        if (bbox_coords && typeof bbox_coords == 'string') {
          bbox_coords = bbox_coords.split(',');
          for (var i=0; i < bbox_coords.length; i++) {
            polygon_path_coords.push(
              new google.maps.LatLng(
                parseFloat(bbox_coords[i].split(' ')[0]),
                parseFloat(bbox_coords[i].split(' ')[1])
              )
            );
          };

          selection_polygon.setOptions({fillOpacity: 0.40});
          selection_polygon.setPath(polygon_path_coords);
          selection_polygon.setMap(map);

          var bounds = new google.maps.LatLngBounds();
          selection_polygon.getPath().forEach(function(item, index){
            bounds.extend(item);
          });
          map.setCenter(bounds.getCenter());
          map.fitBounds(bounds);
        };

        google.maps.event.addListener(map,"click",function(event){
          changeMapSelectionStatus(event.latLng);
        });
      };
    };

    var  changeMapSelectionStatus = function(latlng) {
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
          dump_to_hidden_field(selection_polygon);
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
    };

    function dump_to_hidden_field(polygon){
      var coords = [];
      polygon.getPath().forEach(function(item, index){
        coords.push(item.lat() + ' ' + item.lng());
      });
      $('input#site_geographic_boundary_box').val(coords.join(','));
    };