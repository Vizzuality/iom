  var map;
  var bounds = new google.maps.LatLngBounds();


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
      if ($('input[name="site[overview_map_bbox_miny]"]').attr('value')!='') {
        bounds.extend(new google.maps.LatLng($('input[name="site[overview_map_bbox_miny]"]').attr('value'),$('input[name="site[overview_map_bbox_minx]"]').attr('value')));
        bounds.extend(new google.maps.LatLng($('input[name="site[overview_map_bbox_maxy]"]').attr('value'),$('input[name="site[overview_map_bbox_maxx]"]').attr('value')));
      } else {
        bounds.extend(new google.maps.LatLng(0,0));
      }

     var myOptions = {
        scrollwheel: false,
        mapTypeControl: false,
        streetViewControl: false,
        mapTypeId: google.maps.MapTypeId.TERRAIN,
        disableDefaultUI: true,
        zoom: 1,
        center: bounds.getCenter()
      }
      map = new google.maps.Map(document.getElementById("map"), myOptions);
      map.fitBounds(bounds);
      google.maps.event.addListener(map, "bounds_changed", function(ev) {
          var map_bounds = map.getBounds();

          $('input[name="site[overview_map_bbox_maxy]"]').attr('value',map_bounds.getNorthEast().lat());
          $('input[name="site[overview_map_bbox_maxx]"]').attr('value',map_bounds.getNorthEast().lng());

          $('input[name="site[overview_map_bbox_miny]"]').attr('value',map_bounds.getSouthWest().lat());
          $('input[name="site[overview_map_bbox_minx]"]').attr('value',map_bounds.getSouthWest().lng());
      });

    });

    function hideAllMapCombos(){
         $('div.list_combo').find('ul.list_combo_content').css('display','none');
         $('div.list_combo').children('span.combo_large').attr('id','hidden');
         $('div.list_combo').children('span.combo_large').removeClass('displayed');
    }