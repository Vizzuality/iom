$(document).ready(function(ev){

  var hasChanged = false;

  $('.chzn-container').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

  });

  $('span.combo_date').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    $(this).addClass('open');

    if ($('span.combo_date').hasClass('clicked')) {

      $('span.combo_date:not(.open)').removeClass('clicked');

      if (hasChanged) {
        $('form').closest('form').submit();
        hasChanged = false;
      }
    }

    $(this).toggleClass('clicked');
    $(this).removeClass('open');
  });

  $(document).click(function(event) {
    if ( $('span.combo_date').hasClass('clicked')) {
      $('span.combo_date').not(event.target).removeClass('clicked');
      if (hasChanged) {
        $('form').closest('form').submit();
        hasChanged = false;
      }
    }
  });

  $(".chzn-select").change(function() {
    $(this).closest('form').submit();
  });

  $('select').change(function(){
    hasChanged = true;
  });

  $('.changes_list .change .more a').live('click', function(evt){
    evt.preventDefault();
    var change = $(this).closest('.change');
    if (change.hasClass('open')){
      change.find('.detail').slideToggle(function(){
        change.toggleClass('open');
      });
    }else{
      change.toggleClass('open');
      change.find('.detail').slideToggle();
    }
  });

});

