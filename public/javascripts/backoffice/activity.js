$(document).ready(function(ev){

  $('span.combo_date').dateCombos({submitOnChange: true});
  $(".chzn-users-select").chosen();
  $(".chzn-types-select").chosen({hide_search :true});

  $('.chzn-container').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
  });

  $(".chzn-select, .chzn-users-select, .chzn-types-select").change(function() {
     $(this).closest('form').submit();
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

  $('.changes_list .change .reviewed form').submit(function(evt){
    evt.preventDefault();
    var $form    = $(this)
      , $hidden  = $form.find('.value')
      , reviewed = $hidden.val()
      ;

    $form.closest('.change').toggleClass('checked');
    $hidden.val(reviewed == 'true' ? false : true);
    $.post($form.attr('action'), $form.serialize());
  });
});

