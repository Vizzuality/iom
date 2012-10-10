

$(document).ready( function() {
  //If right part is bigger than float left
  resizeColumn();
  setupEmbedMapPopup();
});


function resizeColumn() {
  if ($('div#left_column div.float_left').height() < $('div#left_column div.right').height()) {
    var offset =  $('div#left_column div.right').height() - $('div#left_column div.float_left').height() + 41;
    var h_ = $('div#left_column div.float_left div.block').last().height();
    $('div#left_column div.float_left div.block').last().height(offset + h_);
  }

  if ($('div#left_column div.float_left').height() > $('div#left_column div.left').height()) {
    $('div#left_column div.left').height($('div#left_column div.float_left').height() - 40);
  }

  // TO ADAPT BACKGROUND MESH ON LEFT COLUMN
  $('div#left_column div.outer_float').height($('div#left_column div.float_left').height() - 40);
}

function setupEmbedMapPopup(){
  $('#embed_map').click(function(evt){
    evt.preventDefault();
    $('#popup.embed_map, .popup_background').fadeIn('fast');
  });

  $('.popup_background').click(function(){
    $('#popup.embed_map, .popup_background').fadeOut('fast');
  })

  $('#popup.embed_map a').click(function(evt){
    evt.preventDefault();
    $('#popup.embed_map, .popup_background').fadeOut('fast');
  });
}
