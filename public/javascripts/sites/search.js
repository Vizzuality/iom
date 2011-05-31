$(document).ready(function() {
  $('.autocomplete').focus(function(){
    this.select();
  });

  var cache = {};

  $('ul.filter_list li a.delete').live('click', function(evt){
    evt.preventDefault();

    var input_ids = $(this).closest('ul.filter_list').parent().find('input.ids');
    var ids = input_ids.val().split(',').removeByValue($(this).attr('rel'))

    input_ids.val(ids.join(','))

    $(this).parent().fadeOut(function(){
      $(this).remove();
    });

    $('form').submit();
  });

  $('input.autocomplete').each(function(index, element){
    $(element).data('data_class', $(element).closest('div.block').attr('class').replace('block', '').trim());
    $(element).autocomplete({
      'minLength': 2,
      'position': {'offset': '1 -2'},
      'source': function(request, response) {
        if ( request.term in cache ) {
          response( cache[ request.term ] );
          return;
        };

        var data_class = $(this.element).data('data_class');
        filtered_items = $.grep(autocomplete_data[data_class], function(item, index){
          return item[data_class].title.match(new RegExp(request.term, "gi"));
        })

        results = $.map(filtered_items, function(item, index){
          return item[data_class];
        });

        cache[ request.term ] = results;
        response( results );
      },
      'focus': function(event, ui) {
        if (ui && ui.item) {
          var value = [ui.item.title];
          if (ui.item.subtitle) {
            value.push(ui.item.subtitle);
          };

          $(this).val(value.join(', '));
        };

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

        var label = [ui.item.title];
        if (ui.item.subtitle) {
          label.push(ui.item.subtitle);
        };
        label = label.join(', ');
        $(this).val(label);

        var a = $("." + data_class + " ul.filter_list li:last-child a").clone();

        if (a.length == 0) {
          a = $('<a>', {'href': '#'}).addClass('delete').append($('<img>', {'src': '/images/sites/search/autocomplete_x.png', 'alt': 'delete'}));
        };
        a.attr('rel', ui.item.id);

        $("." + data_class + " ul.filter_list").append($("<li>", {"text": label}).append(a)).css('height', null);

        $(this).val('Add a ' + (word_for[data_class] || data_class));

        $('form').submit();

        return false;
      },
      'open': function(event, ui) {
        $('ul.ui-autocomplete').addClass('scroll_pane').jScrollPane({
          autoReinitialise:false,
          showArrows: false,
          verticalGutter: 5
        });
      }
    })
    .data( "autocomplete" )._renderItem = function( ul, item ) {

      var
          data_class = $(this.element).data('data_class'),
          label = ['<a href="#"><span class="' + data_class + '">' + item.title + '</span>'];

      if (item.subtitle) {
        label.push('<span class="subtitle">' + item.subtitle + '</span></a>')
      };
      return $( "<li></li>" )
        .data( "item.autocomplete", item )
        .append( label.join('') )
        .appendTo( ul );
    };
  });
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