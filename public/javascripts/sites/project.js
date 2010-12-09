
      $(document).ready( function() {
        
        //Number of men for painting
        $('span.people_amount').width($('span.people_amount').attr('estimate')/1000);
        
        //If right part is bigger than float left
        if ($('div#project div.float_right').height() < $('div#project div.left').height()) {
          var offset =  $('div#project div.left').height() - $('div#project div.float_right').height();
          $('div#project div.float_right').append('<div class="block margin"></div>');
          $('div#project div.float_right div.block:last').height(offset);
        }
        if ($('div#project div.float_right').height() > $('div#project div.right').height()) {
          $('div#project div.right').height($('div#project div.float_right').height());
        }
        
              
        //Days left effect
        var d = new Date();       
        var total_days = daydiff(parseDate($('p.first_date').text()), parseDate($('p.second_date').text()));
        var days_completed = daydiff(parseDate($('p.first_date').text()), parseDate((d.getDate())+'/'+(d.getMonth()+1)+'/'+(d.getFullYear())));
        if (days_completed<(total_days/2)) {
          $('div.timeline p').css('color','#999999');
        }
        $('div.timeline span').width((days_completed*237)/total_days);

        //Gallery
        // if ($('div.image_gallery').length>0) {
        //           //Galleria.loadTheme('galleria/src/themes/galleria/galleria.classic.js');
        //           $('div.image_gallery').galleria();
        //         }
        
        
        //Google map
        var myOptions = {
              zoom: 4,
              center: new google.maps.LatLng(40.4166909, -3.7003454),
              disableDefaultUI: true,
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

