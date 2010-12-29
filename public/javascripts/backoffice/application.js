var old_value;

// TO IMPORT CSV
var data_info = new Object();

$(document).ready(function(ev){
  
    //Media - resources error
    if ($('p.resource_error').length>0) {
      $('p.resource_error').insertBefore('div#new_image');
      $('p.resource_error:eq(0)').remove();
      $('p.resource_error').show();
    }
  
    
    // TO SET COMBO OPTIONS CHECKED
    if ($('div#published_status').length > 0){
        var id = $('input#page_published').val();
        $('div#published_status').find('a#'+id).addClass('clicked');
    }
    
    
    // CUSTOM SCROLLBARS
    if ($('.scroll_pane').length > 0){
    
        $('.scroll_pane').jScrollPane({
                           autoReinitialise:false });
    }

    if ($('div.right.menu').length>0) {
      setTimeout(function(){
        $('div.right.menu').height($('div.block div.med div.left').height());
        $('div.export_import,div.delete', $('div.right.menu')).show();
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
    
      // We are using the same modal window with other options        
      if ($('div#modal_window').children('div.alert').hasClass('import_csv')){
          $('div#modal_window').children('div.alert').removeClass('import_csv');
      }  
      if ($('div#modal_window').children('div.alert').hasClass('ok')){
          $('div#modal_window').children('div.alert').removeClass('ok');
      }
      if ($('div#modal_window').children('div.alert').hasClass('error')){
          $('div#modal_window').children('div.alert').removeClass('error');              
      }
            
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
    
    $('div#modal_window a.ok').click(function(ev){
        
    });
    
  
});

    // CLICK ON IMPORT LINK TO SIMULATE CLICK ON INPUT FILE (HIDDEN)
    // Window processing CSV
    function importCSV (){
          $('div#modal_window').find('a.cancel').css('display','none');

          // GET DATA
          // var href_ = $(this).attr('destroy_url');
          // var name_ = $(this).attr('att_name');
          
          data_info.num_projects = 36;  // TODO: Change this value when is finished
          data_info.num_errors = 42;    // TODO: Change this value when is finished  

          if ($('div.alert').hasClass('import_csv')) $('div.alert').removeClass('import_csv');
          if ($('div.alert').hasClass('ok')) $('div.alert').removeClass('ok');
          if ($('div.alert').hasClass('error')) $('div.alert').removeClass('error');
          
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
          
    
        $('div#modal_window h4').text('Processing file...');
        $('div#modal_window p').text(data_info.num_projects+' projects processed. Please wait.');
        $('div#modal_window').children('div.alert').addClass('import_csv');
        $('div#modal_window').fadeIn();
        
        // IN DEVELOPMENT 
        setTimeout("importCSV_result('ok')",2000);
    }
    
    function importCSV_result (status) {

        if (!$('div#modal_window').find('a.cancel').hasClass('ok'))
            $('div#modal_window').find('a.cancel').addClass('ok');
        
        if (status == 'ok'){
            $('div.import_csv').addClass('ok');
            $('div#modal_window h4').text('Great! ');
            
            $('div#modal_window p').text(data_info.num_projects+' projects updated succesfully :-)');
            
        }else if (status == 'error'){

                $('div.import_csv').addClass('error');

                $('ul#errors_csv').jScrollPane({
                                   autoReinitialise:false });

                if (!$('div#modal_window').find('a.ok').hasClass('error'))
                    $('div#modal_window').find('a.ok').addClass('error');
                    $('div#modal_window h4').text('There are '+data_info.num_errors+' problems with the selected file');
                    $('div#modal_window p').text('The information has not  been updated. Please, correct the original file and try again.');                                    
                
        }
        $('div#modal_window').find('a.cancel').css('display','inline');


    }

 function capitaliseFirstLetter(string) {
     if (string!=null){
        return string.charAt(0).toUpperCase() + string.slice(1);
     }
     else {
         return ''
     }

 }


 function removeAndGo(location) {
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
      if (element.length >0){
          var api = element.data('jsp');
          api.reinitialise();
      }
  }
