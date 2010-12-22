

    $(document).ready( function() {
        
        $('ul.filter_list').each(function(index,element){
          var list_size_compress = $(element).height();
          $(element).find('li.out').css('display','none');
          var list_size = $(element).height();
          $(element).height(list_size);
          $(element).css('overflow','hidden');
          $(element).parent().children('a.more').attr('title',list_size_compress);
          $(element).parent().children('a.more').click(function(){
            $(this).parent().find('li.out').css('display','block');
            var size = $(this).attr('title') + 'px';
            $(this).parent().find('ul').animate({height: size},500, function(){
              $(this).parent().find('a.more').remove();
            });
          });

        });
        
        
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
        $('input#q').focusin(function(ev){
          var value = $(this).attr('value');
          if (value == "Search...") {
            old_value = value;
            $(this).attr('value','');
          }
        });
        $('input#q').focusout(function(ev){
          var value = $(this).attr('value');
          if (value == "") {
            $(this).attr('value',old_value);
          }
        });
        

    });
