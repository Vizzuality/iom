
  $(document).ready( function() {
    
    
    //add caption or edit
    
    
    
    //remove text input
    $('input.vimeo').focusin(function(ev){
      var value = $(this).attr('value');
      if (value == "Enter a Vimeo URL") {
        $(this).attr('value','');
      }
    });
    $('input.vimeo').focusout(function(ev){
      var value = $(this).attr('value');
      if (value == "") {                                      
        $(this).attr('value',"Enter a Vimeo URL");
      }
    });
    
    //add video or image
    $('.toggle_image_video').click(function(){
      $('#new_image').toggle();
      $('#new_video').toggle();
      return false;
    });
  });