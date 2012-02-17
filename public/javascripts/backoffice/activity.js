$(document).ready(function(ev){
  $('.changes_list .change .more a').live('click', function(evt){
    evt.preventDefault();
    var change = $(this).closest('.change');
    change.toggleClass('open');
    change.find('.detail').slideToggle();
  });
});

