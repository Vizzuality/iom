IOM = {
  ajax_pagination: function() {
    $('a.ajax').attr('data-remote', 'true');
  }
}

$(document).ready( function() {

    // TODO: update scrollbar to content
    // if ($('.scroll_pane_auto').length > 0){
    //
    //     $('.scroll_pane_auto').jScrollPane({
    //                        autoReinitialise:true });
    // }


    // LIVE SEARCH IN ORGANIZATIONS
    $('#ngos_search').val('');
    $('#ngos_search').liveUpdate('orgs_list');

    // CUSTOM SCROLLBARS
    if ($('.scroll_pane').length > 0){

        $('.scroll_pane').jScrollPane({
                           autoReinitialise:false });
    }


    $('span.input_search input').focusin(function(ev){
      var value = $(this).attr('value');
      if (value == "Search...") {
        old_value = value;
        $(this).attr('value','');
      }
    });
    $('span.input_search input').focusout(function(ev){
      var value = $(this).attr('value');
      if (value == "") {
        $(this).attr('value',old_value);
      }
    });


    // TO SHOW CLUSTER'S TOOLTIPS
    $('ul.statistics_list li a').hover(function(){

        $(this).parent().children('div#tooltip').css('display','inline');
    },
      function() {
        $(this).parent().children('div#tooltip').css('display','none');
      }
    );


  // MENU CLICKS
  $('ul.menu li a.main_option.with_suboptions').click(function(ev){
      ev.stopPropagation();
      ev.preventDefault();

      if (($(this).children('span.with_suboptions').length > 0)&&(!$(this).hasClass('displayed'))){
          console.log('entra');
          // Close all tabs
          $('ul.menu li a.displayed').removeClass('displayed');
          $('ul.menu li.clicked').removeClass('clicked');

          $(this).addClass('displayed');
          $(this).parent().addClass('clicked');

          // If there are some scroll
          if ($(this).parent().find('.scroll_pane').length > 0){
            resetCombo($(this).parent());
          }

          $(document).click(function(event) {
                if ((!$(event.target).closest('ul.suboptions li a').length)&&(!$(event.target).closest('ul.scroll_pane').length)&&(!$(event.target).closest('input#ngos_search').length))               
                {
                  $('ul.menu li.clicked').removeClass('clicked');
                  $('ul.menu li a.displayed').removeClass('displayed');
                };
              });
      }
      else {
          $('ul.menu li a.displayed').removeClass('displayed');
      }
  });

  IOM.ajax_pagination();

});

function resetCombo(elementToUpdate){
    var element = elementToUpdate.find('.scroll_pane');
    var api = element.data('jsp');
    api.reinitialise();
}
