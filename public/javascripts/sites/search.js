$(document).ready(function() {
  var autocomplete_offset;
  if ($.browser.webkit || $.browser.opera) {
    autocomplete_offset = '0 0'
  }else if($.browser.mozilla){
    autocomplete_offset = '1 0'
  };

  $('#delete_date_filter').click(function(evt){
    evt.preventDefault();
    $('select#date_start_month,select#date_start_year,select#date_end_month,select#date_end_year').val(null);
    $('form#search').submit();
  });

  $('ul.filter_list li a.delete').live('click', function(evt){
    evt.preventDefault();

    var input_ids = $(this).closest('ul.filter_list').parent().find('input.ids');
    var ids = input_ids.val().split(',').removeByValue($(this).attr('rel'))

    input_ids.val(ids.join(','))

    $(this).parent().fadeOut(function(){
      $(this).remove();
    });

    $('form#search').submit();
  });

  $('input.autocomplete').each(function(index, element){
    $(element).data('data_class', $.trim($(element).closest('div.block').attr('class').replace('block', '')));
    $(element)
    .after(
      $('<div/>').css({
        'position': 'absolute',
        'bottom': 0,
        'right': 12,
        'width': 20,
        'height': 20,
        'cursor': 'pointer'
      })
      .click(function(){
        var autocomplete = $(this).prev('input.autocomplete');
        if (autocomplete.hasClass('opened')) {
          $(this).prev('input.autocomplete').blur();
        }else{
          $(this).prev('input.autocomplete').focus();
        };
      })
    )
    .autocomplete({
      'minLength': 0,
      'position': {'offset': autocomplete_offset},
      'source': function(request, response) {

        var data_class = $(this.element).data('data_class');
        filtered_items = $.grep(autocomplete_data[data_class], function(item, index){
          return item.title.match(new RegExp(request.term, "gi"));
        })

        results = $.map(filtered_items, function(item, index){
          return item;
        });

        response( results );
      },
      'focus': function(event, ui) {
        if (!ui || !ui.item) { return; };

        return false;
      },
      'select': function(event, ui) {
        if (!ui || !ui.item) { return; };

        var data_class = $(this).data('data_class');
        var input_ids = $('input.' + data_class + 's.ids');
        var ids = [];
        if (input_ids.val() && input_ids.val() != '') {
          ids = input_ids.val().split(',');
        };
        ids.push(ui.item.id);
        input_ids.val(ids.join(','));

        var label = ui.item.title;
        $(this).val(label);

        var a = $("." + data_class + " ul.filter_list li:last-child a").clone();

        if (a.length == 0) {
          a = $('<a>', {'href': '#'}).addClass('delete');
          $('<img>', {'src': '/images/sites/search/autocomplete_x.png', 'alt': 'delete'}).load(function(){
            $(this).appendTo(a);

            a.attr('rel', ui.item.id);

            $("." + data_class + " ul.filter_list").append($("<li>", {"text": label}).append(a)).css('height', null);

            $(this).val('Add a ' + (word_for[data_class] || data_class));

            $('form#search').submit();
          });
        }else{
          a.attr('rel', ui.item.id);

          $("." + data_class + " ul.filter_list").append($("<li>", {"text": label}).append(a)).css('height', null);

          $(this).val('Add a ' + (word_for[data_class] || data_class));

          $('form#search').submit();
        };

        return false;
      },
      'open': function(event, ui) {
        $(this)
        .addClass('opened')
        .autocomplete('widget')
        .data('jsp', null)
        .jScrollPane({
          autoReinitialise: false,
          showArrows: false,
          verticalGutter: 5
        });
      },
      'close': function(event, ui){
        $(this).removeClass('opened');
      }
    })
    .data( "autocomplete" )._renderItem = function( ul, item ) {

      var
        label
        data_class = $(this.element).data('data_class');

      label = '<a href="#">' + item.title + '</a>'

      return $( "<li></li>" )
        .data( "item.autocomplete", item )
        .append( label )
        .appendTo( ul );
    };
  })
  .mouseup(function(evt){
    return false;
  })
  .focus(function(){
    $(this).select().autocomplete('search', '');
  })
  .blur(function(){
    if (!$(this).val() || $(this).val() == '') {
      $(this).val($(this).data('previous_value'));
    };
  });

  $('select#date_start_year').change(function(evt){
    $('form#search').submit();
  });

  $('select#date_start_month').change(function(evt){
    if ($('select#date_start_month').val() && $('select#date_start_year').val()) {
      $('form#search').submit();
    };
  });
  $('select#date_end_year').change(function(evt){
    $('form#search').submit();
  });
  $('select#date_end_month').change(function(evt){
    if ($('select#date_end_month').val() && $('select#date_end_year').val()) {
      $('form#search').submit();
    };
  });

  $('select#date_start_month').sSelect({ddMaxWidth: '107px', ddMaxHeight: '107px', containerClass: 'month'});
  $('select#date_start_year').sSelect({ddMaxWidth: '63px', ddMaxHeight: '107px', containerClass: 'year'});
  $('select#date_end_month').sSelect({ddMaxWidth: '107px', ddMaxHeight: '107px', containerClass: 'month'});
  $('select#date_end_year').sSelect({ddMaxWidth: '63px', ddMaxHeight: '107px', containerClass: 'year'});

  if ($('.scroll_pane').length > 0){
    $('.scroll_pane').jScrollPane({
      autoReinitialise: false,
      showArrows: false,
      verticalGutter: 5
    });
  };
});

Array.prototype.removeByValue = function(val) {
  for(var i=0; i<this.length; i++) {
    if(this[i] == val) {
      this.splice(i, 1);
      break;
    }
  }
  return this;
};