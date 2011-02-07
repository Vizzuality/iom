  var map;
  var bounds_ = new google.maps.LatLngBounds();


    $(document).ready( function() {
      $('#site_show_blog').click(function(){
        if (!$('#tumbler_id').is(':visible')) {
          $(this).parent().addClass('selected');
        } else {
          $(this).parent().removeClass('selected');
        }
        $('#tumbler_id').toggle();
      });

      $('a.manage_partners').click(function(ev){
        ev.preventDefault();
        ev.stopPropagation();
        var position = $('a.manage_partners').position();
        $('#manage_partners').css('top',position.top-360+'px');
        $('#manage_partners').css('left',position.left-145+'px');
        $('#manage_partners').fadeIn();

        $(window).resize(function() {
          var position = $('a.manage_partners').position();
          $('#manage_partners').css('top',position.top-360+'px');
          $('#manage_partners').css('left',position.left-145+'px');
        });
      });

      $('a.close').click(function(){
        $(window).unbind('resize');
        $('#manage_partners').fadeOut();
      });

      //change value tumblr input value
      $('#tumblr').focusin(function(ev){
        if ($(this).attr('value')=="Please write Tumblr ID") {
          $(this).attr('value','');
        }
      });
      $('#tumblr').focusout(function(ev){
        if ($(this).attr('value')=="") {
          $(this).attr('value','Please write Tumblr ID');
        }
      });


      $('ul.themes li').click(function(ev){
        if (!$(this).hasClass('selected')) {
          $('ul.themes li').removeClass('selected');
          $(this).addClass('selected');
          $('#site_theme_id').val($(this).attr('rel'));
        }
      });
      
      
      $('#zoomIn,#zoomOut').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();
      });


      // CHANGE EACH LIST
      $('ul.list_combo_content').find('li.element').click(function(ev){
        var id = $(this).attr('id');
        var name = $(this).children('p.project_name').text();

        $('input#project_primary_organization_id').val($(this).attr('id'));
        $('div.list_combo').find('a.organization').text(name);
        $('div.list_combo').find('ul.list_combo_content').css('display','none');
        $('div.list_combo').children('span.combo_large').attr('id','hidden');
        $('div.list_combo').children('span.combo_large').removeClass('displayed');
      });

      if ($('a.combo').length > 0){
          $('a.combo').click(function(ev){
             if (!$(this).hasClass('clicked')){
                 $('a.combo.clicked').removeClass('clicked');
                 $(this).addClass('clicked');
             }
             $('input#site_project_classification').val($(this).attr('id'));
          });
      }


      //Map customization
      if ($('#site_overview_map_bbox_minx').attr('value')!='') {
        bounds_.extend(new google.maps.LatLng($('#site_overview_map_bbox_miny').attr('value'),$('#site_overview_map_bbox_minx').attr('value')));
        bounds_.extend(new google.maps.LatLng($('#site_overview_map_bbox_maxy').attr('value'),$('#site_overview_map_bbox_maxx').attr('value')));
      } else {
        bounds_.extend(new google.maps.LatLng(0,0));
      }

     var myOptions = {
        scrollwheel: false,
        mapTypeControl: false,
        streetViewControl: false,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        disableDefaultUI: true,
        zoom: 1,
        center: bounds_.getCenter()
      }
      map = new google.maps.Map(document.getElementById("map"), myOptions);

      var marker = new google.maps.Marker({
              position: new google.maps.LatLng($('#site_overview_map_bbox_miny').attr('value'),$('#site_overview_map_bbox_minx').attr('value')), 
              map: map,
              title:"Hello World!"
          });
      var marker = new google.maps.Marker({
              position: new google.maps.LatLng($('#site_overview_map_bbox_maxy').attr('value'),$('#site_overview_map_bbox_maxx').attr('value')), 
              map: map,
              title:"Hello World!"
          });
  
      google.maps.event.addListener(map, "tilesloaded", function(ev) {
        map.fitBounds(bounds_);
        zoomIn();
        google.maps.event.clearListeners(map,"tilesloaded");
        google.maps.event.addListener(map, "bounds_changed", function(ev) {
          var map_bounds = map.getBounds();
          $('#site_overview_map_bbox_maxy').attr('value',map_bounds.getNorthEast().lat());
          $('#site_overview_map_bbox_minx').attr('value',map_bounds.getNorthEast().lng());
          $('#site_overview_map_bbox_miny').attr('value',map_bounds.getSouthWest().lat());
          $('#site_overview_map_bbox_maxx').attr('value',map_bounds.getSouthWest().lng());
        });
      });
    });

    function hideAllMapCombos(){
     $('div.list_combo').find('ul.list_combo_content').css('display','none');
     $('div.list_combo').children('span.combo_large').attr('id','hidden');
     $('div.list_combo').children('span.combo_large').removeClass('displayed');
    }


    function zoomIn() {
      map.setZoom(map.getZoom() + 1);
    }

    function zoomOut() {
      map.setZoom(map.getZoom() - 1);
    }