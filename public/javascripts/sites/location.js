
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
      

      
      //Google map
      var myOptions = {
            zoom: 4,
            center: new google.maps.LatLng(40.4166909, -3.7003454),
            disableDefaultUI: true,
            mapTypeId: google.maps.MapTypeId.ROADMAP
          }
      var map = new google.maps.Map(document.getElementById("map"),myOptions);
      var map2 = new google.maps.Map(document.getElementById("secondary_map"),myOptions);
      map2.setCenter(new google.maps.LatLng(40.42245660632275, -3.699495792388916));
      map2.setZoom(17);
    });