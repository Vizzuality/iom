IOM = {
  ajax_pagination: function() {
    $('a.ajax').attr('data-remote', 'true');
  }
}

$(document).ready( function() {
  IOM.ajax_pagination();
});