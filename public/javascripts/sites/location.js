

    $(document).ready( function() {
      
      //See more in the clusters
      if ($('ul#donors_list').length>0) {
        var list_height = $('ul#donors_list').height();
        $('a#show_donor_list').css('cursor','pointer');
        $('a#show_donor_list').click(function(){
          growList(list_height);
        });
        $('ul#donors_list li.out').css('display','none');
        $('ul#donors_list').css('overflow','hidden');
        $('ul#donors_list').height($('ul#donors_list').height());
      }
      
      
      //If description is bigger than main_head
      if ($('div.inner_main_head div.right').height()>$('div.inner_main_head div.left').height()) {
        $('div.inner_main_head div.left').height($('div.inner_main_head div.right').height());
        
        if ($('div.inner_main_head div.float_head').height() < $('div.inner_main_head div.right').height()) {
          $('div.inner_main_head div.float_head').height($('div.inner_main_head div.right').height());
        } else {
          var left_height = $('div.inner_main_head div.float_head').height();
          var right_height = $('div.inner_main_head div.right').height();
          var actual_height = $('div.inner_main_head div.right').height();
          var height_to_add = (left_height - right_height) + parseInt(actual_height);
          $('div.inner_main_head div.right').height(height_to_add);
          $('div.inner_main_head div.left').height($('div.inner_main_head div.right').height());        
        }
      }
      
      // If right part is bigger than float left
      setTimeout(function(){resizeColumn()},50);
    });
    
    
    function resizeColumn() {
      if (($('div#left_column div.float_left').height()-40) < $('div#left_column div.right').height()) {
        var offset =  $('div#left_column div.right').height() - $('div#left_column div.float_left').height() + 70;
        if ($('div.block:last').hasClass('green')) {
          $('div#left_column div.float_left').append('<div class="block"></div>');
          $('div#left_column div.float_left div.block:last').height(offset);
          $('div#left_column div.outer_float').height($('div#left_column div.float_left').height()-40);
          $('div#left_column div.left').height($('div#left_column div.outer_float').height());
        } else {
          $('div#left_column div.float_left div.block:last').height($('div#left_column div.float_left div.block:last').height()+offset);
          $('div#left_column div.outer_float').height($('div#left_column div.float_left').height()-40);
          $('div#left_column div.left').height($('div#left_column div.outer_float').height());
        }
      } else {
        $('div#left_column div.outer_float').height($('div#left_column div.float_left').height()-40);
        $('div#left_column div.left').height($('div#left_column div.outer_float').height());
      }
    }
    
    function growList(list_height) {
      $('ul#donors_list li.out').css('display','block');
      $('ul#donors_list').animate({height: list_height+'px'},200,function(ev){
        $('#show_donor_list').hide();
        resizeColumn();
      });
    }