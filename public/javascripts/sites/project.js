
      $(document).ready( function() {
        
        //Number of men for painting
        $('span.people_amount').width($('span.people_amount').attr('estimate')/1000);
        
        //If left part is bigger than float right
        if ($('div#project div.float_left').height() < $('div#project div.right').height()) {
          var offset =  $('div#project div.right').height() - $('div#project div.float_left').height();
          $('div#project div.float_left').append('<div class="block margin"></div>');
          $('div#project div.float_left div.block:last').height(offset);
          $('div#project div.outer_float').height($('div#project div.float_left').height()-40);
          $('div#project div.left').height($('div#project div.float_left').height()-40);
        }
        
        $('div#completed').css('bottom','-10px');
              
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

      });
      
      
      function parseDate(str) {
          var mdy = str.split('/')
          return new Date(mdy[2], mdy[1]-1, mdy[0]);
      }

      function daydiff(first, second) {
          return (second-first)/(1000*60*60*24)
      }

