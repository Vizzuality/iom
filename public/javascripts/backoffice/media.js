
  $(document).ready( function() {

    //add caption or edit
    $('p.caption a').click(function(ev){
      $(this).parent().hide();
      $(this).parent().parent().find('div.caption').show();
    });

    //remove text input
    $('input.video').focusin(function(ev){
      var value = $(this).attr('value');
      if (value == "Enter a Vimeo or Youtube URL") {
        $(this).attr('value','');
      }
    });
    $('input.video').focusout(function(ev){
      var value = $(this).attr('value');
      if (value == "") {
        $(this).attr('value',"Enter a Vimeo or Youtube URL");
      }
    });

    //add video or image
    $('.toggle_image_video').click(function(){
      $('#new_image').toggle();
      $('#new_video').toggle();
      return false;
    });
  });
