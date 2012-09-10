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
        if ((!$(event.target).closest('span.region_combo').length)&&(!$(event.target).closest('.scroll_pane').length)) {
          me.removeClass('clicked');
        };
      });
    });


    addComboListListener();

    $('#regions_list a.close').live('click',function (e){
      e.preventDefault();
      e.stopPropagation();
      $(this).closest('li').remove();
    });

    $('a#add_region_to_list').click(function (e){
        var i = 0;
        var countries_ids = [];
        var regions_ids = [];
        var countries_names = [];
        var regions_names = [];
        $('div.region_window div span.region_combo p').each(function(index,element){
          if ($(element).text()!="Not specified") {
            if(i == 0){
              countries_ids.push($(element).attr('id').split('_')[1]);
              countries_names.push($(element).html());
            } else {
              regions_ids.push($(element).attr('id').split('_')[1]);
              regions_names.push($(element).html());
            }
          }
          i++;
        });

        if( regions_ids.length == 0 )
          $('#regions_list').append('<li><p>'+countries_names[0]+'</p><input type="hidden" name="project[regions_ids][]" value="country_'+countries_ids[0]+'" /><a href="javascript:void(null)" class="close"></a></li>');
        else {
          var breadcrumb = [];
          breadcrumb.push(countries_names[0]);
          for(var i = 0;i<regions_names.length;i++) {
            breadcrumb.push(regions_names[i]);
          }
          $('#regions_list').append('<li><p>'+breadcrumb.join(' > ')+'</p><input type="hidden" name="project[regions_ids][]" value="region_'+regions_ids[regions_ids.length - 1]+'" /><a href="javascript:void(null)" class="close"></a></li>');
        }

        e.preventDefault();
        e.stopPropagation();

        $('div.region_window').fadeOut(function(e){
          resetRegionValues();
        });
    });

  });


  function addComboListListener() {
    $('span.region_combo ul li').livequery('click',function(ev){
      console.log('entra')

      var mega_parent = $(this).parent().parent().parent().parent().parent();
      var new_item = $(this).children('a');

      if (new_item.text().length>30) {
        mega_parent.children('p').text(new_item.text().substr(0,27) + "...");
      } else {
        mega_parent.children('p').text(new_item.text());
      }
      mega_parent.children('p').attr('id',new_item.attr('id'));


      var item_level;
      var item_id;
      var next_element;


      //Get the block (level 1,2,3 or country)
      if (mega_parent.parent().hasClass('level_0')) {
        item_level = 1;
        item_id = new_item.attr('id').split('_')[1];
        next_element = $('div.level_1');

        $('div.level_1').children('span.region_combo').children('p').text('Not specified');
        $('div.level_1').children('span.region_combo').children('p').attr('id','level'+item_level+'_0');

        $('div.level_1').hide();
        $('div.level_2').hide();
        $('div.level_3').hide();

      } else if (mega_parent.parent().hasClass('level_1')) {
        item_level = 2;
        item_id = new_item.attr('id').split('_')[1];
        next_element = $('div.level_2');

        $('div.level_2').children('span.region_combo').children('p').text('Not specified');
        $('div.level_2').children('span.region_combo').children('p').attr('id','level'+item_level+'_0');

        $('div.level_2').hide();
        $('div.level_3').hide();

      } else if (mega_parent.parent().hasClass('level_2')) {
        item_level = 3;
        item_id = new_item.attr('id').split('_')[1];
        next_element = $('div.level_3');

        $('div.level_3').children('span.region_combo').children('p').text('Not specified');
        $('div.level_3').children('span.region_combo').children('p').attr('id','level'+item_level+'_0');

        $('div.level_3').hide();

      } else {
        mega_parent.removeClass('clicked');
        return false;
      }


      mega_parent.parent().find('img.loader').show();


      //If not specified - hide nexts fields, else
      if (new_item.text()=="Not specified") {
        $('img.loader').hide();
        if (item_level==1) {
          $('div.region_window div.bottom_region').prepend($('div.level_1'));
          $('div.region_window div.bottom_region').prepend($('div.level_0'));
          $('div.region_window div.bottom_region').prepend($('div.region_window p.info_region_exp'));
          $('div.region_window div.bottom_region').prepend($('div.region_window h3'));
        } else if (item_level==2) {
          $('div.region_window div.bottom_region').prepend($('div.level_1'));
          $('div.region_window div.bottom_region').prepend($('div.level_0'));
        } else if (item_level==3){
          $('div.region_window div.top_region').append($('div.level_0'));
          $('div.region_window div.bottom_region').prepend($('div.level_1'));
        } else {
          $('div.region_window div.bottom_region').prepend($('div.region_window p.info_region_exp'));
          $('div.region_window div.bottom_region').prepend($('div.region_window h3'));
        }
      } else {
        $.getJSON('/geo/regions/'+item_level+'/'+item_id+'/json?' + (new Date().getTime()),function(result){
          var settings = {showArrows: false};
          var pane = next_element.children('span.region_combo').children('div.wrapper').children('ul.scroll_pane')
          pane.jScrollPane(settings);
          var api = pane.data('jsp');
          api.getContentPane().children('li').remove();
          api.getContentPane().append('<li><a id="level'+ item_level + '_0">Not specified</a></li>');
          for (var i=0; i<result.length; i++) {
            api.getContentPane().append('<li><a id="level'+ item_level + '_'+result[i].id +'">'+result[i].name+'</a></li>');
          }
          api.getContentPane().append('<li class="last"></li>');


          if (item_level==1) {
            $('div.region_window div.bottom_region').prepend($('div.level_0'));
            $('div.region_window div.top_region').append($('div.region_window h3'));
            $('div.region_window div.top_region').append($('div.region_window p.info_region_exp'));
          } else if (item_level==2) {
            $('div.region_window div.bottom_region').prepend($('div.level_1'));
            $('div.region_window div.top_region').append($('div.region_window h3'));
            $('div.region_window div.top_region').append($('div.region_window p.info_region_exp'));
            $('div.region_window div.top_region').append($('div.level_0'));
          } else {
            $('div.region_window div.top_region').append($('div.region_window h3'));
            $('div.region_window div.top_region').append($('div.region_window p.info_region_exp'));
            $('div.region_window div.top_region').append($('div.level_0'));
            $('div.region_window div.top_region').append($('div.level_1'));
          }
          next_element.show();

          $('img.loader').hide();
        });
      }
    });
  }


  function resetRegionValues() {
    $('div.level_1').hide();
    $('div.level_2').hide();
    $('div.level_3').hide();

    $('div.region_window img.loader').hide();

    $('div.region_window div.bottom_region').prepend($('div.level_1'));
    $('div.region_window div.bottom_region').prepend($('div.level_0'));
    $('div.region_window div.bottom_region').prepend($('div.region_window p.info_region_exp'));
    $('div.region_window div.bottom_region').prepend($('div.region_window h3'));


    $('div.level_0 span p').attr('id','country_0');
    $('div.level_0 span p').text('Not specified');

    $('div.level_1 span p').attr('id','level1_0');
    $('div.level_1 span p').text('Not specified');

    $('div.level_2 span p').attr('id','level2_0');
    $('div.level_2 span p').text('Not specified');

    $('div.level_3 span p').attr('id','level3_0');
    $('div.level_3 span p').text('Not specified');
  }
