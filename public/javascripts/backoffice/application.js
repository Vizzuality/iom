
  $(document).ready(function(ev){
    if ($('div.right.menu').length>0) {
      $('div.right.menu').height($('div.block div.med div.left').height());
    }
    
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
  });