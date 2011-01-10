

  $(document).ready( function() {
      if ($('div#footer_sites').length > 0){
        var dif_height = $('div.body').height() - $('div.left').height();
        $('div#footer_sites').css('padding-top',dif_height - 40);
      }
  });

