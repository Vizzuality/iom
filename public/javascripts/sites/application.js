IOM = {
  ajax_pagination: function() {
    $('a.ajax').attr('data-remote', 'true');
  }
}

//IE Problems (DONT TOUCH)
if ($.browser.msie) {
  $('div#header ul.menu li#cluster_option a:eq(0)').css('width','70px');
  $('div#header ul.menu li#country_option a:eq(0)').css('width','70px');
  $('div#header ul.menu li#region_option a:eq(0)').css('width','65px');
  $('div#header ul.menu li#organization_option a:eq(0)').css('width','110px');
}



$(document).ready( function() {


    if ($.browser.msie) {
      var zIndexNumber = 1000;  
      $('div,ul').each(function() {  
        $(this).css('zIndex', zIndexNumber);  
        zIndexNumber -= 10;  
      });

      $('div.loader_gallery').css('zIndex',1000);
      $('div#header').css('zIndex',1000);
      $('div#float_head').css('zIndex',100);
      $('div#map').css('zIndex',0);
      $('div#small_map').css('zIndex',0);
      $('div.inner_header').css('zIndex',1000);
      $('ul.menu').css('zIndex',1000);
      $('ul.suboptions').css('zIndex',1000);
    }

    // TODO: update scrollbar to content
    if ($('.scroll_pane_auto').length > 0){    
        $('.scroll_pane_auto').jScrollPane({
                           autoReinitialise:true });
    }


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
    $('ul.statistics_list li a').hover(function(ev){
        ev.stopPropagation();
        ev.preventDefault();        
        //$('div.tooltip').each(function(element){ $(element).css('display','none'); });
        $(this).parent().children('div.tooltip').show();
    },
      function() {
        $(this).parent().children('div.tooltip').hide();
      }
    );


  // MENU CLICKS
  $('ul.menu li a.main_option.with_suboptions').click(function(ev){
      ev.stopPropagation();
      ev.preventDefault();

      if (($(this).children('span.with_suboptions').length > 0)&&(!$(this).hasClass('displayed'))){
          // Close all tabs
          $('ul.menu li a.displayed').removeClass('displayed');
          $('ul.menu li.clicked').removeClass('clicked');

          $(this).addClass('displayed');
          $(this).parent().addClass('clicked');

          // If there are some scroll
          if ($(this).parent().find('.scroll_pane').length > 0){
            resetCombo($(this).parent());
          }
          
          // if there are some input text
          if ($(this).parent().find('input#ngos_search').length > 0){
              $(this).parent().find('input#ngos_search').focus();
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
    if (element.length > 0){
        var api = element.data('jsp');    
        if (api != undefined) api.reinitialise();
    }
}