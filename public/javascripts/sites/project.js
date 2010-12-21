
      $(document).ready( function() {
        
        //Number of men for painting
        $('span.people_amount').width($('span.people_amount').attr('estimate')/1000);
        
        //If right part is bigger than float left
        if ($('div#project div.float_right').height() < $('div#project div.left').height()) {
          var offset =  $('div#project div.left').height() - $('div#project div.float_right').height();
          $('div#project div.float_right').append('<div class="block margin"></div>');
          $('div#project div.float_right div.block:last').height(offset);
        }
        
        
        if ($('div.inner_main_head div.right').height() > $('div.inner_main_head div.left').height()) {
          $('div.inner_main_head div.left').height($('div.inner_main_head div.right').height());

        }else {
          $('div.inner_main_head div.right').height($('div.inner_main_head div.left').height());    
        }
        
        $('div.inner_main_head div.head').height($('div.inner_main_head div.left').height()-39);
        $('div.inner_main_head div.right').height($('div.inner_main_head div.head').height()+39);
        $('div.projects div#mash.right').height($('div#project div.left').height()+ 39);
        
        $('div#completed').css('bottom','0px');
              
        //Days left effect
        var d = new Date();       
        var total_days = daydiff(parseDate($('p.first_date').text()), parseDate($('p.second_date').text()));
        var days_completed = daydiff(parseDate($('p.first_date').text()), parseDate((d.getDate())+'/'+(d.getMonth()+1)+'/'+(d.getFullYear())));
        if (days_completed<(total_days/2)) {
          $('div.timeline p').css('color','#999999');
        }else if (days_completed >= total_days){
            $('div.timeline p').text('COMPLETED');
            $('div#completed').css('display','inline');
        }
        
        $('div.timeline span').width((days_completed*237)/total_days);

        //Gallery
  			if ($('div.galleryStyle').length>0){		
  	      Galleria.loadTheme('/javascripts/plugins/galleria.classic.js');
  			  $('div.galleryStyle').galleria({thumbnails:false, preload:2,autoplay:5000,transition:'fade',show_counter:'false'});
  			}
        
        
        //Google map
        var myOptions = {
              zoom: 4,
              center: new google.maps.LatLng(40.4166909, -3.7003454),
              disableDefaultUI: true,
              scrollwheel:false,              
              mapTypeId: google.maps.MapTypeId.ROADMAP
            }
        var map = new google.maps.Map(document.getElementById("small_map"),myOptions);
      });
      
      
      function parseDate(str) {
          var mdy = str.split('/')
          return new Date(mdy[2], mdy[1]-1, mdy[0]);
      }

      function daydiff(first, second) {
          return (second-first)/(1000*60*60*24)
      }

