

    $(document).ready( function() {
      
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
      resizeColumn();

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