
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
      
      //  HOME_MAP_COMBO
      $('div#home_map_combo').children('span.combo_large').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();

        hideAllMapCombos();
        
        if ($(this).attr('id') == 'hidden'){
          $('div#home_map_combo').find('ul.list_combo_content').css('display','inline');
          $(this).addClass('displayed');
          $(this).attr('id','visible');
        }else{
          $('div#home_map_combo').find('ul.list_combo_content').css('display','none');
          $(this).attr('id','hidden');
          $(this).removeClass('displayed');
        }

        $(document).click(function(event) {
          if (!$(event.target).closest('ul.list_combo_content').length) {
            $('div#home_map_combo').find('ul.list_combo_content').css('display','none');
            $('div#home_map_combo').children('span.combo_large').attr('id','hidden');
            $('div#home_map_combo').children('span.combo_large').removeClass('displayed');
          };
        });
      });
      
      
      //  project_map_combo
      $('div#project_map_combo').children('span.combo_large').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();
        
        hideAllMapCombos();
        
        if ($(this).attr('id') == 'hidden'){
          $('div#project_map_combo').find('ul.list_combo_content').css('display','inline');
          $(this).addClass('displayed');
          $(this).attr('id','visible');
        }else{
          $('div#project_map_combo').find('ul.list_combo_content').css('display','none');
          $(this).attr('id','hidden');
          $(this).removeClass('displayed');
        }

        $(document).click(function(event) {
          if (!$(event.target).closest('ul.list_combo_content').length) {
            $('div#project_map_combo').find('ul.list_combo_content').css('display','none');
            $('div#project_map_combo').children('span.combo_large').attr('id','hidden');
            $('div#project_map_combo').children('span.combo_large').removeClass('displayed');
          };
        });
      });
      
       //  region_map_combo
        $('div#region_map_combo').children('span.combo_large').click(function(ev){
          ev.stopPropagation();
          ev.preventDefault();
          
          hideAllMapCombos();
          
          if ($(this).attr('id') == 'hidden'){
            $('div#region_map_combo').find('ul.list_combo_content').css('display','inline');
            $(this).addClass('displayed');
            $(this).attr('id','visible');
          }else{
            $('div#region_map_combo').find('ul.list_combo_content').css('display','none');
            $(this).attr('id','hidden');
            $(this).removeClass('displayed');
          }

          $(document).click(function(event) {
            if (!$(event.target).closest('ul.list_combo_content').length) {
              $('div#region_map_combo').find('ul.list_combo_content').css('display','none');
              $('div#region_map_combo').children('span.combo_large').attr('id','hidden');
              $('div#region_map_combo').children('span.combo_large').removeClass('displayed');
            };
          });
        });

        //  cluster_map
        $('div#cluster_map').children('span.combo_large').click(function(ev){
          ev.stopPropagation();
          ev.preventDefault();
        
          hideAllMapCombos();
          
          if ($(this).attr('id') == 'hidden'){
            $('div#cluster_map').find('ul.list_combo_content').css('display','inline');
            $(this).addClass('displayed');
            $(this).attr('id','visible');
          }else{
            $('div#cluster_map').find('ul.list_combo_content').css('display','none');
            $(this).attr('id','hidden');
            $(this).removeClass('displayed');
          }

          $(document).click(function(event) {
            if (!$(event.target).closest('ul.list_combo_content').length) {
              $('div#cluster_map').find('ul.list_combo_content').css('display','none');
              $('div#cluster_map').children('span.combo_large').attr('id','hidden');
              $('div#cluster_map').children('span.combo_large').removeClass('displayed');
            };
          });
        });
        
         //  ngo_map_combo
            $('div#ngo_map_combo').children('span.combo_large').click(function(ev){
              ev.stopPropagation();
              ev.preventDefault();
              
              hideAllMapCombos();
              
              if ($(this).attr('id') == 'hidden'){
                $('div#ngo_map_combo').find('ul.list_combo_content').css('display','inline');
                $(this).addClass('displayed');
                $(this).attr('id','visible');
              }else{
                $('div#ngo_map_combo').find('ul.list_combo_content').css('display','none');
                $(this).attr('id','hidden');
                $(this).removeClass('displayed');
              }

              $(document).click(function(event) {
                if (!$(event.target).closest('ul.list_combo_content').length) {
                  $('div#ngo_map_combo').find('ul.list_combo_content').css('display','none');
                  $('div#ngo_map_combo').children('span.combo_large').attr('id','hidden');
                  $('div#ngo_map_combo').children('span.combo_large').removeClass('displayed');
                };
              });
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
      
    });
    
    function hideAllMapCombos(){
         $('div.list_combo').find('ul.list_combo_content').css('display','none');
         $('div.list_combo').children('span.combo_large').attr('id','hidden');
         $('div.list_combo').children('span.combo_large').removeClass('displayed');
    }