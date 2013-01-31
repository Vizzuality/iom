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

    //See all tooltip
    $("a#see_all").hover(function(){
      var position = $(this).position();
      $(this).parent().children('div.tooltip').css('top',position.top-65+'px');
      $(this).parent().children('div.tooltip').css('left',position.left-23+'px');
      $(this).parent().children('div.tooltip').show();
    },function(){
      $(this).parent().children('div.tooltip').hide();
    });

    $("a#see_all").click(function(ev){ev.preventDefault(); ev.stopPropagation();});


    // if ($.browser.msie) {
    //   var zIndexNumber = 1000;
    //   $('div,ul').each(function() {
    //     $(this).css('zIndex', zIndexNumber);
    //     zIndexNumber -= 10;
    //   });
    //
    //   $('div.loader_gallery').css('zIndex',1000);
    //   $('div#header').css('zIndex',1000);
    //   $('div#float_head').css('zIndex',100);
    //   $('div#map').css('zIndex',0);
    //   $('div#small_map').css('zIndex',0);
    //   $('div.inner_header').css('zIndex',1000);
    //   $('ul.menu').css('zIndex',1000);
    //   $('ul.suboptions').css('zIndex',1000);
    //   $('ul.ui-autocomplete').css('zIndex',1000);
    //
    // }

    // TODO: update scrollbar to content
    if ($('.scroll_pane_auto').length > 0){
        $('.scroll_pane_auto').jScrollPane({autoReinitialise:true });
    }


    // LIVE SEARCH IN ORGANIZATIONS
    $('#ngos_search').val('');
    if(document.getElementById('orgs_list')) {
      $('#ngos_search').liveUpdate('orgs_list');
    }

    // CUSTOM SCROLLBARS
    if ($('.scroll_pane').length > 0){
        $('.scroll_pane').jScrollPane({
                           autoReinitialise:false });
    }

    if ($('span.input_search input').val() == '') {
      $('span.input_search label').show();
    };
    $('span.input_search input').focusin(function(ev){
      $(this).prev('label').fadeOut();
    });
    $('span.input_search input').focusout(function(ev){
      var value = $(this).attr('value');
      if (value == "") {
        $(this).prev('label').fadeIn();
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

  setupEmbedMapPopup();
});

function resetCombo(elementToUpdate){
    var element = elementToUpdate.find('.scroll_pane');
    if (element.length > 0){

        // TO region option menu (it's liquid - height "auto") I have to specify a height for the plugin
        if (element.attr('id') == $('ul#regions').attr('id')){
            var maxHeight = element.css('max-height');
            element.css('height',maxHeight);
        }
        var api = element.data('jsp');
        if (api != undefined) api.reinitialise();
    }
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
