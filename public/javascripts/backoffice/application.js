var old_value;


$(document).ready(function(ev){

    // CUSTOM SCROLLBARS
    if ($('.scroll_pane').length > 0){

        // OTHER ATTEMP
        $('.scroll_pane').jScrollPane({
                           autoReinitialise:false });
    }

    if ($('div.right.menu').length>0) {
      setTimeout(function(){
        $('div.right.menu').height($('div.block div.med div.left').height());
        $('div.export,div.import,div.delete', $('div.right.menu')).show();
      },300);
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


    //window alert -> delete something (NGO, donor, site, project or object)
    $('div.delete a, a.delete').click(function(ev){
      ev.stopPropagation();
      ev.preventDefault();
      var scroll_position = window.pageYOffset;
      var window_height = (typeof window.innerHeight != 'undefined' ? window.innerHeight : document.body.offsetHeight);
      $('div#modal_window').css('height',window_height+'px');
      $('div#modal_window').css('top',scroll_position+'px');
      $('body').css('overflow','hidden');
      $(window).resize(function() {
        var scroll_position = window.pageYOffset;
        var window_height = (typeof window.innerHeight != 'undefined' ? window.innerHeight : document.body.offsetHeight);
        $('div#modal_window').css('height',window_height+'px');
        $('div#modal_window').css('top',scroll_position+'px');
      });
      var href_ = $(this).attr('destroy_url');
      var name_ = $(this).attr('att_name');

      $('div#modal_window a.remove').click(function(evt){
        evt.preventDefault();
        removeAndGo(href_);
      });
      $('div#modal_window h4').text('You are about deleting this '+capitaliseFirstLetter(name_));
      $('div#modal_window p').text('If you delete this '+name_+', it will not appear in any site.');
      $('div#modal_window').fadeIn();
    });

    $('div#modal_window a.cancel').click(function(ev){
      ev.stopPropagation();
      ev.preventDefault();
      $(window).unbind('resize');
      $('body').css('overflow','auto');
      $('div#modal_window').fadeOut();
    });


    //change preview link if twitter/facebook/website changes
    $('input.website').change(function(ev){
      $('a#website').attr('href',$(this).attr('value'));
    });
    $('input.twitter').change(function(ev){
      $('a#twitter').attr('href','http://twitter.com/'+$(this).attr('value'));
    });
    $('input.facebook').change(function(ev){
      $('a#facebook').attr('href',$(this).attr('value'));
    });

    //if there is an error in some field
    $('a.error').hover(
      function() {
        $(this).parent().find('div.error_msg').show();
      }
    );
    $('div.error_msg p').hover(function(){},
      function() {
        $(this).parent().hide();
      }
    );

    //if there is an error in some field
    $('a.simple_error').hover(
      function() {
        $(this).parent().find('div.error_msg').show();
      }
    );


         // $('div').each(function() {
         //              $(this).css('zIndex', zIndexNumber);
         //              zIndexNumber -= 10;
         //          });


});



 function capitaliseFirstLetter(string) {
     if (string!=null){
        return string.charAt(0).toUpperCase() + string.slice(1);
     }
     else {
         return ''
     }

 }


 function removeAndGo(location) {
console.debug(location);
   var form = $('<form method="post" action="'+location+'"></form>');
   var metadata_input = '<input name="_method" value="delete" type="hidden" />';
   form.hide()
       .append(metadata_input)
       .appendTo('body');
   form.submit();
 }



  function limitChars(textid, limit, infodiv) {
    var text = $('#'+textid).val();

    var textlength = text.length;
    if(textlength > limit) {
      $('#' + infodiv).html(limit+' chars written');
      $('#'+textid).val(text.substr(0,limit));
      return false;
    }else {
      if (limit - textlength <= 10){
          $('#' + infodiv).addClass('few');
      }else if ($('#' + infodiv).hasClass('few')){
          $('#' + infodiv).removeClass('few');
      }
      $('#' + infodiv).html((limit - textlength) +' chars left');
      return true;
    }
  }

  function resetCombo(elementToUpdate){
      var element = elementToUpdate.find('.scroll_pane');
      var api = element.data('jsp');
      api.reinitialise();
  }
