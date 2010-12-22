
    $(document).ready( function() {
      
      //If description is bigger than main_head
      if ($('div.inner_main_head div.right').height()>$('div.inner_main_head div.left').height()) {
        $('div.inner_main_head div.left').height($('div.inner_main_head div.right').height());
        $('div.inner_main_head div.float_head').height($('div.inner_main_head div.right').height() + 40);
      }
      
            
      if ($('div#left_column div.float_left').height() < $('div#left_column div.right').height()) {
        var offset =  $('div#left_column div.right').height() - $('div#left_column div.float_left').height() + 120;
        if ($('div.block.green').is(':visible')) {
          $('div#left_column div.float_left').append('<div class="block"></div>');
          $('div#left_column div.float_left div.block:last').height(offset);
        } else {
          $('div#left_column div.float_left div.block:last').height(offset);
        }
      }
      
      if ($('div#left_column div.float_left').height() > $('div#left_column div.left').height()) {
        $('div#left_column div.left').height($('div#left_column div.float_left').height());
      }
      
      //If right part is bigger than float left
      $('div#left_column div.outer_float').height($('div#left_column div.left').height()-41);
      
      
      // TO ADAPT LEFT AND RIGHT COLUMN PROPERLY
      if ($('div#left_column div.outer_float').height() > $('div#left_column div.right').height()){
        $('div#left_column div.right').height($('div#left_column div.outer_float').height());
      } else {
        $('div#left_column div.outer_float').height($('div#left_column div.right').height());
        var dif = $('div#left_column div.outer_float').height() - ($('div#left_column div.float_left').height());
        $('div#most_active_orgs').height($('div#most_active_orgs').height() + dif + 41);
      }

    });