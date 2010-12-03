
      $(document).ready( function() {
        var myOptions = {
              zoom: 4,
              center: new google.maps.LatLng(40.4166909, -3.7003454),
              disableDefaultUI: true,
              mapTypeId: google.maps.MapTypeId.ROADMAP
            }
        var map = new google.maps.Map(document.getElementById("small_map"),myOptions);
      });