
    $(document).ready( function() {
      $('#site_show_blog').click(function(){
        if (!$('#tumbler_id').is(':visible')) {
          $(this).parent().addClass('selected');
        } else {
          $(this).parent().removeClass('selected');
        }
        $('#tumbler_id').toggle();
      });

      $('a.manage_partners').click(function(ev){
        ev.preventDefault();
        ev.stopPropagation();
        var position = $('a.manage_partners').position();
        $('#manage_partners').css('top',position.top-360+'px');
        $('#manage_partners').css('left',position.left-145+'px');
        $('#manage_partners').fadeIn();

        $(window).resize(function() {
          var position = $('a.manage_partners').position();
          $('#manage_partners').css('top',position.top-360+'px');
          $('#manage_partners').css('left',position.left-145+'px');
        });
      });

      $('a.close').click(function(){
        $(window).unbind('resize');
        $('#manage_partners').fadeOut();
      });

      //change value tumblr input value
      $('#tumblr').focusin(function(ev){
        if ($(this).attr('value')=="Please write Tumblr ID") {
          $(this).attr('value','');
        }
      });
      $('#tumblr').focusout(function(ev){
        if ($(this).attr('value')=="") {
          $(this).attr('value','Please write Tumblr ID');
        }
      });


      $('ul.themes li').click(function(ev){
        if (!$(this).hasClass('selected')) {
          $('ul.themes li').removeClass('selected');
          $(this).addClass('selected');
          $('#site_theme_id').val($(this).attr('rel'));
        }
      });
    });