
    $(document).ready( function() {
        
      //Parent page combo
      $('span#parent_page').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();
        if (!$(this).hasClass('clicked')){
          $(this).addClass('clicked');
        }else {
          $(this).removeClass('clicked');
        }
        $(document).click(function(event) {
          if (!$(event.target).closest('span.parent_page').length) {
            $('span.parent_page.clicked').removeClass('clicked');
          };
        });
      });
      
      $("select#page_parent_id option:selected").each(function(index,element){
        $('span#parent_page p').attr('id',$(element).attr('value'));
        $('span#parent_page p').text($(element).text());
      });
      
      
      $('span#parent_page ul.options li').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();
        var id_ = $(this).children('a').attr('id');
        $('span#parent_page').children('p').text($(this).children('a').text());
        $('span#parent_page').children('p').attr('id',$(this).children('a').attr('id'));
        $('span#parent_page.clicked').removeClass('clicked');
        $('#page_parent_id option').each(function(index,element){
          if ($(element).attr('value')==id_) {
            $(element).attr('selected','selected');
          }
        });
      });
    
      if ($('a.combo').length > 0){
          $('a.combo').click(function(ev){
             if (!$(this).hasClass('clicked')){
                 $('a.combo.clicked').removeClass('clicked');
                 $(this).addClass('clicked');
             }
             $('input#page_published').val($(this).attr('id'));
          });
      }
    });