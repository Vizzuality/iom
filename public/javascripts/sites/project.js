
      var vimeo_total = 0;
      var vimeo_count = 0;

      $(document).ready( function() {
        
        //Number of men for painting
        $('span.people_amount').width($('span.people_amount').attr('estimate')/5);
        $('span.people_amount').css('display','block');
        
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
        
        if ($('div.galleryStyle img').size()>0) {
          
          $('div.loader_gallery').css('top',$('div.galleryStyle').position().top+1+'px');
          $('a.video').css('top',$('div.galleryStyle').position().top+150+'px');
          $('div.loader_gallery').show();
          $('div.mamufas').remove();
          
          
          var vimeo_total = $('div.galleryStyle img[title="video"]').size();
          
          $('div.galleryStyle img[title="video"]').each(function(index,element){
            var vimeo_parts = $(element).attr('src').split('/');
            var vimeo_id = vimeo_parts[vimeo_parts.length-1];
            $.ajax({
              url: 'http://vimeo.com/api/v2/video/'+vimeo_id+'.json?format=jsonp',
              jsonpCallback: "onGetVimeoData",
              dataType: "jsonp",
              type: "GET",
              cache: true,
              success: function(result) {
                $('img[src="'+result[0].url+'"]').attr('src',result[0].thumbnail_large);
                vimeo_count++;
                if (vimeo_count==vimeo_total) {
                  startGalleria();
                }
              }
            });
            if (vimeo_count == vimeo_total) {
              startGalleria();
            }
          });
        }
        
      });
      
      
      
      function parseDate(str) {
          var mdy = str.split('/')
          return new Date(mdy[2], mdy[1]-1, mdy[0]);
      }

      function daydiff(first, second) {
          return (second-first)/(1000*60*60*24)
      }
      
      function startGalleria() {
        if ($('div.galleryStyle').length>0){   
            console.log('entra');
          Galleria.loadTheme('/javascripts/plugins/galleria.sites.js');
          $('div.galleryStyle').galleria({thumbnails:false, preload:2,autoplay:5000,transition:'fade',show_counter:'false'});
          $('div.loader_gallery').delay(300).fadeOut();
        }
      }
      
      
      function playVideo(vimeo_id) {
        $('div.loader_gallery img').remove();
        $('div.loader_gallery p').remove();
        $('div.loader_gallery div.video_player').show();
        $('div.loader_gallery div.video_player').append('<iframe id="vimeo_frame" src="http://player.vimeo.com/video/'+vimeo_id+'" width="660" height="370" frameborder="0"></iframe>');
        $('div.loader_gallery').fadeIn();
      }
      

