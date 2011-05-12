

  $(document).ready( function() {
      if ($('div#footer_sites').length > 0){
        var dif_height = $('div.body').outerHeight() - $('div.left').outerHeight();
        $('div#footer_sites').css('padding-top',dif_height - 40);
      }
  });

