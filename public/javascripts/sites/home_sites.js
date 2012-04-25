$(document).ready( function() {

   if ($('div.content_gallery').length>0){
     $('div.content_gallery').galleria({thumbnails:false, preload:2, autoplay:true, transition:'fade', show_counter:'false'});
   }

});
