$(document).ready(function(ev){

  $('span.combo_date').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
    $('span.combo_date').not(this).removeClass('clicked');
    $(this).toggleClass('clicked');
  });

  $(document).click(function(event) {
    $('span.date_container.clicked').not(event.target).removeClass('clicked');
  });

  $('select').change(function(){
    $(this).closest('form').submit();
  });

  $('#search_who, #search_what_type').sSelect();
  $('#search_when_start_1i,#search_when_end_1i').sSelect({ddMaxWidth: '76px',ddMaxHeight:'200px',containerClass:'year'});
  $('#search_when_start_2i,#search_when_end_2i').sSelect({ddMaxWidth: '131px',ddMaxHeight:'200px',containerClass:'month'});
  $('#search_when_start_3i,#search_when_end_3i').sSelect({ddMaxWidth: '62px',ddMaxHeight:'200px',containerClass:'day'});

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

