  
    /* MENU HACK POSITIONING*/
    $('div#header div.left').width(810);
    
    /* MENU HACK DESCRIPTION*/
    if ($('div.inner_main_head div.right p').length>0) {
      $('div.inner_main_head div.right p').each(function(index,element){
        if (index!=0) {
          $('div.inner_main_head div.right p').append('<br/>'+$(element).html());
          $(element).remove();
        }
      });
      var max_height = $('div.inner_main_head div.left').height();
      $('div.inner_main_head div.right').height(max_height);
      $('div.inner_main_head div.right p').height(max_height);
      $('div.inner_main_head div.right').css('overflow','hidden!important');
      $('div.inner_main_head div.right p').css('overflow','hidden!important');

      var max_characters = ((max_height*6)/76) * 90;
      if ($('div.inner_main_head div.right p').text().length>max_characters) {
        $('div.inner_main_head div.right p').text($('div.inner_main_head div.right p').text().substr(0,max_characters)+'...');
      }
    }
    

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