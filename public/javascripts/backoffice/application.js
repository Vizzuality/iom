var old_value;
var heightLeft;
// TO IMPORT CSV
var data_info = new Object();

$(document).ready(function(ev){

    // To center information projects box
    if ($('div#information_projects').length > 0){
        var account = $('div#information_projects').children('p').text().length;
        var element = $('div#information_projects').children('p');

        var margin_left = 90 - ((account - 1) * 10);
        var margin = '12px 5px 0 '+margin_left+'px';
        element.css('margin',margin);
    }

    // To center information donors box
    if ($('div.one_donor').length > 0){
        var account = $('div.one_donor').children('div.center').children('p').text().length;
        var element = $('div.one_donor').children('div.center').children('p');
        var margin_left = 90 - ((account - 1) * 10);
        var margin = '20px 5px 0 '+margin_left+'px';
        element.css('margin',margin);
    }


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
                           autoReinitialise:false,
                           showArrows: true,
                           verticalGutter: 5});
    }

    if ($('div.right.menu').length > 0) {
        if ($('div.block div.med div.left').height() > $('div.right.menu').height()){
            setTimeout(function(){
              heightLeft = $('div.block div.med div.left').height();
              $('div.right.menu').height(heightLeft);
              $('div.export_import,div.delete', $('div.right.menu')).show();
            },300);
        }else {
            setTimeout(function(){
              $('div.export_import,div.delete', $('div.right.menu')).show();
            },300);
        }
    }

    $('div.block div.med div.left').bind('resize', function(){
        heightLeft = $('div.block div.med div.left').height();
        $('div.right.menu').height(heightLeft);
    });

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
      var no_subtitle = $(this).attr('no_subtitle');

      $('div#modal_window a.remove').click(function(evt){
        evt.preventDefault();
        removeAndGo(href_);
      });
      $('div#modal_window h4').text('You are about deleting this '+capitaliseFirstLetter(name_));
      $('div#modal_window p').text('If you delete this '+name_+', it will not appear in any site.');
      if (no_subtitle) {
        $('div#modal_window p').text('');
      }
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

		$('a.show_password_link').click(function(evt){
      evt.preventDefault();
			if ($(this).text() == "show values") {
				$("input#organization_user_attributes_password").get(0).setAttribute('type','text')
				$("input#organization_user_attributes_password_confirmation").get(0).setAttribute('type','text')
				$(this).text("hide values");
			} else {
				$("input#organization_user_attributes_password").get(0).setAttribute('type','password')
				$("input#organization_user_attributes_password_confirmation").get(0).setAttribute('type','password')
				$(this).text("show values");
			}
    });

		$('.block_user').click(function(evt){
      evt.preventDefault();
			$(this).toggleClass('selected');
			if ($(this).hasClass('selected')){
				$(this).next('input[type=hidden]').val(true);
			} else {
				$(this).next('input[type=hidden]').val(false);
			}
		});

    $('#reset_password').click(function(evt){
      evt.preventDefault();
      var new_password = password();
			$('a.show_password_link').text("hide values");
      $('div.admin .password').each(function(index, item){
        item.setAttribute('type', 'text');
        $(item).val(new_password);
      });

    });

});


    var floatingSubmit = function($submit, $delete){
      if ($submit.length == 0) return;

      var $window          = $(window)
        , container        = $submit.closest('.med')
        , container_offset = container.offset().top
        , form_offset      = $submit.closest('form').offset().top
        , initial_position = $window.height() - 100
        , button_position  = null
        , delete_position  = null;

      if ($submit.length > 0){
        $submit.css({
          top: initial_position
        });
      }

      $window.scroll(function(evt){
        button_position = $submit.offset().top;
        if ($delete.length > 0){
          delete_position = $delete.offset().top;
        }else{
          delete_position = container_offset + container.height() + 85;
        }

        if((delete_position - $window.scrollTop()) <= 946){
          $submit.css({position: 'absolute', top: delete_position - form_offset - 100, left: 438}) ;
        }else{
          $submit.css({position: 'fixed', top: initial_position, left: '50%'});
        }
      });

    }

    // CLICK ON IMPORT LINK TO SIMULATE CLICK ON INPUT FILE (HIDDEN)
    // Window processing CSV
    function importCSV (){
        $('form.edit_organization.sync_projects').submit();
        //   $('div#modal_window').find('a.cancel').css('display','none');
        //
        //   // GET DATA
        //   // var href_ = $(this).attr('destroy_url');
        //   // var name_ = $(this).attr('att_name');
        //
        //   data_info.num_projects = 36;  // TODO: Change this value when is finished
        //   data_info.num_errors = 42;    // TODO: Change this value when is finished
        //
        //   if ($('div.alert').hasClass('import_csv')) $('div.alert').removeClass('import_csv');
        //   if ($('div.alert').hasClass('ok')) $('div.alert').removeClass('ok');
        //   if ($('div.alert').hasClass('error')) $('div.alert').removeClass('error');
        //
        //   var scroll_position = window.pageYOffset;
        //   var window_height = (typeof window.innerHeight != 'undefined' ? window.innerHeight : document.body.offsetHeight);
        //
        //   $('div#modal_window').css('height',window_height+'px');
        //   $('div#modal_window').css('top',scroll_position+'px');
        //   $('body').css('overflow','hidden');
        //
        //   $(window).resize(function() {
        //     var scroll_position = window.pageYOffset;
        //     var window_height = (typeof window.innerHeight != 'undefined' ? window.innerHeight : document.body.offsetHeight);
        //     $('div#modal_window').css('height',window_height+'px');
        //     $('div#modal_window').css('top',scroll_position+'px');
        //   });
        //
        //
        // $('div#modal_window h4').text('Processing file...');
        // $('div#modal_window p').text(data_info.num_projects+' projects processed. Please wait.');
        // $('div#modal_window').children('div.alert').addClass('import_csv');
        // $('div#modal_window').fadeIn();
        //
        // // IN DEVELOPMENT
        // setTimeout("importCSV_result('ok')",2000);
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

                if (!$('div#modal_window').find('a.ok').hasClass('error')){
                    $('div#modal_window').find('a.ok').addClass('error');
                    $('div#modal_window h4').text('There are '+data_info.num_errors+' problems with the selected file');
                    $('div#modal_window p').text('The information has not  been updated. Please, correct the original file and try again.');
                }

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

  function password(length, special) {
    var iteration = 0;
    var password = "";
    var randomNumber;
    if(length == undefined){
      length = Math.RandomInteger(5, 10);
    }
    if(special == undefined){
      var special = false;
    }
    while(iteration < length){
        randomNumber = (Math.floor((Math.random() * 100)) % 94) + 33;
        if(!special){
              if ((randomNumber >=33) && (randomNumber <=47)) { continue; }
              if ((randomNumber >=58) && (randomNumber <=64)) { continue; }
              if ((randomNumber >=91) && (randomNumber <=96)) { continue; }
              if ((randomNumber >=123) && (randomNumber <=126)) { continue; }
            }
        iteration++;
        password += String.fromCharCode(randomNumber);
      }
    return password;
  }

  Math.RandomInteger = function(n, m) {
      if (! m) {m = 1;} // default range starts at 1
      var max = n > m ? n : m; // doesn't matter which value is min or max
      var min = n === max ? m : n; // min is value that is not max
      var d = max - min + 1; // distribution range
      return Math.floor(Math.random() * d + min);
  };
