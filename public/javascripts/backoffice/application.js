
  $(document).ready(function(ev){
    if ($('div.right.menu').length>0) {
      $('div.right.menu').height($('div.block div.med div.left').height());
    }
  });