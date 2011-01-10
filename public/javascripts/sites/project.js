

      /* MENU HACK POSITIONING*/
      $('div#header div.left').width(680);
  
      var vimeo_total = 0;
      var vimeo_count = 0;

      $(document).ready( function() {

        //Number of men for painting
		var people_width = $('span.people_amount').attr('estimate');
			
		people_width = custLog(Number(people_width),10);
        $('span.people_amount').width(255*(people_width/7));
		if ($('span.people_amount').width() == 0) $('span.people_amount').width(5);
        $('span.people_amount').css('display','block');

        //If left part is bigger than float right
        if ($('div#project div.float_left').height() < $('div#project div.right').height()) {
          var offset =  $('div#project div.right').height() - $('div#project div.float_left').height();
          $('div#project div.float_left').append('<div class="block margin"></div>');
          $('div#project div.float_left div.block:last').height(offset);
          $('div#project div.outer_float').height($('div#project div.float_left').height()-40);
          $('div#project div.left').height($('div#project div.float_left').height()-40);
        } else {
          $('div#project div.outer_float').height($('div#project div.float_left').height()-40);
          $('div#project div.left').height($('div#project div.outer_float').height());
        }

        $('div#completed').css('bottom','-10px');

        //Days left effect
        var d = new Date();
        var total_days = daydiff(parseDate($('p.first_date').text()), parseDate($('p.second_date').text()));
        var days_completed = daydiff(parseDate($('p.first_date').text()), parseDate((d.getMonth()+1)+'/'+(d.getDate())+'/'+(d.getFullYear())));
        
        console.log(total_days);
        console.log(days_completed);
        
        if (days_completed >= total_days){
            $('div.timeline p').text('COMPLETED');
            $('div#completed').css('display','inline');
        }

        $('div.timeline span').width((days_completed*237)/total_days);



        if ($('div.galleryStyle img').size()>0) {
          $('div.loader_gallery').css('top',$('div.galleryStyle').position().top+1+'px');
          $('a.video').css('top',$('div.galleryStyle').position().top+150+'px');
          $('div.loader_gallery').show();
          $('div.mamufas').remove();
          startGalleria();
        }

      });



      function parseDate(str) {
          var mdy = str.split('/')
          return new Date(mdy[2], mdy[0]-1, mdy[1]);
      }
      

      function daydiff(first, second) {
          return (second-first)/(1000*60*60*24)
      }
      

      function startGalleria() {
        if ($('div.galleryStyle').length>0) {
          var r = ($.browser.msie)? "?r=" + Math.random(10000) : "";
          Galleria.loadTheme('/javascripts/plugins/galleria.classic.js' + r);
          $('div.galleryStyle').galleria({thumbnails:false, preload:2,autoplay:5000,transition:'fade',show_counter:'false'});
          $('div.loader_gallery').delay(300).fadeOut();
        }
      }


      function playVideo(vimeo_id) {
        $('div.loader_gallery img').remove();
        $('div.loader_gallery p').remove();
        $('div.loader_gallery div.video_player').show();
        $('div.loader_gallery div.video_player').append('<iframe id="vimeo_frame" src="http://player.vimeo.com/video/'+vimeo_id+'?autoplay=1" width="660" height="370" frameborder="0"></iframe>');
        $('div.loader_gallery div.video_player').each(function(index,element){
          if (index!=0) {
            $(element).remove();
          }
        });
        $('div.loader_gallery').fadeIn();
      }

	function custLog(x,base) {
		return (Math.log(x))/(Math.log(base));
	}
	
	function custRound(x,places) {
		return (Math.round(x*Math.pow(10,places)))/Math.pow(10,places)
	}
