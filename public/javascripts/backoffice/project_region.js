

  $(document).ready(function(ev){
    $('a#add_region_map').click(function(ev){
      ev.preventDefault();
      ev.stopPropagation();
      $('div.region_window').fadeIn();
    });
    
    $('div.region_window a.close').click(function(ev){
      ev.preventDefault();
      ev.stopPropagation();
      $('div.region_window').fadeOut(function(ev){
        resetRegionValues();
      });
    });
    
    
    $('span.region_combo').click(function(ev){
      ev.stopPropagation();
      ev.preventDefault();
      if (!$(this).hasClass('clicked')){
        $('span.clicked').removeClass('clicked');
        $(this).addClass('clicked');
        resetCombo($(this));
      } else {
        $('span.clicked').removeClass('clicked');
        $(this).removeClass('clicked');
      }
      
      var me = $(this);
      
      $(document).click(function(event) {
        if ((!$(event.target).closest('span.region_combo').length)&&(!$(event.target).closest('.scroll_pane').length)&&(!$(event.target).closest('div.wrapper ul li a').length)) {
          me.removeClass('clicked');
        };
      });
    });
    
    
    $('span.region_combo ul li a').click(function(ev){
      var mega_parent = $(this).parent().parent().parent().parent().parent().parent();
      
      if ($(this).text().length>30) {
        mega_parent.children('p').text($(this).text().substr(0,27) + "...");
      } else {
        mega_parent.children('p').text($(this).text());
      }
      mega_parent.children('p').attr('id',$(this).attr('id'));
      mega_parent.removeClass('clicked');
    });
    
    
  });
  
  
  function resetRegionValues() {
    $('div.level_1').hide();
    $('div.level_2').hide();
    $('div.level_3').hide();
    
    $('div.country_region span p').attr('id','country_0');
    $('div.country_region span p').text('Not defined');
    
    $('div.level_1 span p').attr('id','level1_0');
    $('div.level_1 span p').text('Not defined');
    
    $('div.level_2 span p').attr('id','level2_0');
    $('div.level_2 span p').text('Not defined');
    
    $('div.level_3 span p').attr('id','level3_0');
    $('div.level_3 span p').text('Not defined');
  }
