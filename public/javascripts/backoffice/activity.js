$(document).ready(function(ev){

  var hasChanged = [];

  hasChanged['start'] = false;
  hasChanged['end']   = false;

  function isBlank(str) {
    return (!str || /^\s*$/.test(str));
  }

  function allSelected(kind) {
    var month =  !isBlank($("#search_when_"+kind+"_2i_chzn span").html());
    var day   =  !isBlank($("#search_when_"+kind+"_3i_chzn span").html());
    var year  =  !isBlank($("#search_when_"+kind+"_1i_chzn span").html());

    return month && day && year;
  }

  $('.chzn-container').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
  });

  $('span.combo_date').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    $(this).addClass('open');

    if ($('span.combo_date').hasClass('clicked')) {

      var id   = $('span.combo_date.open select').attr('id');
      var kind = (id.indexOf("end") != -1) ? "end" : "start";

      $('span.combo_date:not(.open)').removeClass('clicked');


      if (hasChanged[kind] && allSelected(kind)) {
        $('form').closest('form').submit();
        hasChanged[kind] = false;
      }
    }

    $(this).toggleClass('clicked');
    $(this).removeClass('open');

  });

  $(document).click(function(event) {
    if ($('span.combo_date').hasClass('clicked')) {

      var id   = $('span.combo_date.clicked select').attr('id');
      var kind = (id.indexOf("end") != -1) ? "end" : "start";

      $('span.combo_date').not(event.target).removeClass('clicked');

      if (hasChanged[kind] && allSelected(kind)) {
        $('form').closest('form').submit();
        hasChanged[kind] = false;
      }
    }
  });

  $(".chzn-select, .chzn-users-select, .chzn-types-select").change(function() {
     $(this).closest('form').submit();
  });

  $('select').change(function(){

    var id = $(this).attr('id');
    var kind = (id.indexOf("end") != -1) ? "end" : "start";

    if (allSelected(kind)) {

      var m    = parseInt($("select#search_when_"+kind+"_2i option:selected").val());
      if (m < 10) m = "0" + m;

      var day  =  parseInt($("#search_when_"+kind+"_3i_chzn span").html());
      if (day < 10) day = "0" + day;

      var year =  $("#search_when_"+kind+"_1i_chzn span").html();
      var date = m + "/" + day + "/" + year;

      $(this).parents(".combo_date").find("p:eq(0)").html(date);
    }

    hasChanged[kind] = true;

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

