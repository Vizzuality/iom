$(document).ready( function() {

  if ($('div.content_gallery').length>0){
    var r = ($.browser.msie)? "?r=" + Math.random(10000) : "";
    Galleria.loadTheme('/javascripts/plugins/galleria.home.js' + r);
    $('div.content_gallery').galleria({thumbnails:false, preload:2,autoplay:true,transition:'fade',show_counter:'false'});
  }

});
