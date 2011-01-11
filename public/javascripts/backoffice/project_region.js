

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


    $('span.region_combo ul li').livequery('click',function(ev){
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
        $.getJSON('/geo/regions/'+item_level+'/'+item_id+'/json',function(result){
          $('img.loader').hide();
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
        });
      }
    });

    $('#regions_list a.close').live('click',function (e){
      e.preventDefault();
      e.stopPropagation();
      var csrf_token = $('meta[name=csrf-token]').attr('content'),
          csrf_param = $('meta[name=csrf-param]').attr('content');

      var link = $(this),
          href = link.attr('href'),
          method = 'post',
          form = $('<form method="post" action="'+href+'"></form>'),
          metadata_input = '<input name="_method" value="'+method+'" type="hidden" />',
          countries = [], regions = [];

      if (csrf_param != null && csrf_token != null) {
        metadata_input += '<input name="'+csrf_param+'" value="'+csrf_token+'" type="hidden" />';
      }
      metadata_input += '<input name="type_and_id" value="'+$(this).attr('rel')+'" type="hidden" />';
      form.hide()
          .append(metadata_input)
          .appendTo('body');
      var el = form;
      var data = el.is('form') ? el.serializeArray() : [];

      $.ajax({
        url: href,
        data: form.serializeArray(),
        dataType: 'script',
        type: method.toUpperCase()
      });
    });

    $('a#add_region_to_list').click(function (e){
        var csrf_token = $('meta[name=csrf-token]').attr('content'),
            csrf_param = $('meta[name=csrf-param]').attr('content');

        var link = $(this),
            href = link.attr('href'),
            method = 'post',
            form = $('<form method="post" action="'+href+'"></form>'),
            metadata_input = '<input name="_method" value="'+method+'" type="hidden" />',
            countries = [], regions = [];

        if (csrf_param != null && csrf_token != null) {
          metadata_input += '<input name="'+csrf_param+'" value="'+csrf_token+'" type="hidden" />';
        }

        var i = 0;
        $('div.region_window div span.region_combo p').each(function(index,element){
          if ($(element).text()!="Not specified") {
            if(i == 0){
              countries.push($(element).attr('id').split('_')[1]);
            } else {
              regions.push($(element).attr('id').split('_')[1]);
            }
          }
          i++;
        });

        if( regions.length == 0 )
          metadata_input += '<input name="project[project_countries]" value="'+countries.join(',')+'" type="hidden" />';
        else
          metadata_input += '<input name="project[project_regions]" value="'+regions.join(',')+'" type="hidden" />';

        form.hide()
            .append(metadata_input)
            .appendTo('body');
        var el = form;
        var data = el.is('form') ? el.serializeArray() : [];
        $.ajax({
            url: href,
            data: form.serializeArray(),
            dataType: 'script',
            type: method.toUpperCase(),
            beforeSend: function (xhr) {
                el.trigger('ajax:loading', xhr);
            },
            success: function (data, status, xhr) {
                el.trigger('ajax:success', [data, status, xhr]);
            },
            complete: function (xhr) {
                el.trigger('ajax:complete', xhr);
            },
            error: function (xhr, status, error) {
                el.trigger('ajax:failure', [xhr, status, error]);
            }
        });
        e.preventDefault();
        e.stopPropagation();
        $('div.region_window').fadeOut(function(e){
          resetRegionValues();
        });
    });

  });


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
