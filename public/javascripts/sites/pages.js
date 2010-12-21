

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
        
        
        //remove text from input
        $('input.main_search').focusin(function(ev){
          var value = $(this).attr('value');
          if (value == "Search donors by name, place,..." || value == "Search Organizations by name, place,..." || value == "Search projects by name, place,..." || value == "Search sites by name, place,...") {
            old_value = value;
            $(this).attr('value','');
          }
        });
        $('input.main_search').focusout(function(ev){
          var value = $(this).attr('value');
          if (value == "") {
            $(this).attr('value',old_value);
          }
        });
        
        
        // $('ul.filter_list').each(function(element){
        //   if ($(element).children('li').size()>10) {
        //     var compress_list = $(element);
        //     
        //   }
        // });

    });