

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
        
        
        //Check space in the layout
        resizeColumn();
        
        
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
        
        // if ($('div#footer_sites').length > 0){
        //   var dif_height = $('div.body').height() - $('div.left').height();
        //   $('div#footer_sites').css('padding-top',dif_height - 40);
        // }
    });
    
    
    function resizeColumn() {
      if ($('div#pages div.float_left').height() > ($('div#pages div.right').height() + 120)) {
        var offset =  $('div#pages div.float_left').height();
        $('div#pages div#relative_content').height(offset);
      } else {
        var offset =  $('div#pages div.right').height() + 180;
        $('div#pages div#relative_content').height(offset+142);
        $('div#pages div.float_left div.results_list').height(offset - $('div#pages div.float_left div.head').height());
        $('div#pages div.float_left div.body').height(offset - $('div#pages div.float_left div.head').height());
      }
    }
