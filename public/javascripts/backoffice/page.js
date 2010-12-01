
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
    
    });
    
    
    
    function limitChars(textid, limit, infodiv) {
      var text = $('#'+textid).val(); 
      var textlength = text.length;
      if(textlength > limit) {
        $('#' + infodiv).html(limit+' chars written');
        $('#'+textid).val(text.substr(0,limit));
        return false;
      } else {
        $('#' + infodiv).html((limit - textlength) +' chars left.');
        $('#' + infodiv).css('color','#999999');
        return true;
      }
    }