

    $(document).ready( function() {
        if ($('div#pages div.float_left').height() > ($('div#pages div.right').height() + 120)) {
          var offset =  $('div#pages div.float_left').height();
          $('div#pages div.left').height(offset);
        } else {
          var offset =  $('div#pages div.right').height() + 180;
          $('div#pages div.left').height(offset+50);
          $('div#pages div.float_left div.results_list').height(offset - $('div#pages div.float_left div.head').height());
          $('div#pages div.float_left div.body').height(offset - $('div#pages div.float_left div.head').height());
        } 
    });