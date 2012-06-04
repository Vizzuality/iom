jQuery.fn.dateCombos = (function(options){
  var defaults    = {
        submitOnChange: false
      }
    , allSelected = function(combos){
        var with_value = combos.filter(function(){return $(this).val() != ''});

        return with_value.length === 3;
      }
    , combos_widths = {
        '1i': 90,
        '2i': 140,
        '3i': 63
      }
    , all_dates = this
    ;

  options = $.extend(defaults, options);

  return this.each(function(){
    var $widget     = $(this)
      , $combos     = $widget.find('select')
      ;

    $widget.click(function(ev){
      ev.stopPropagation();
      ev.preventDefault();

      all_dates.removeClass('clicked');
      $widget.addClass('open');

      if ($widget.hasClass('clicked')) {

        all_dates.filter(':not(.open)').removeClass('clicked');

        if (options.submitOnChange && $widget.data('has-changed') && allSelected($combos)) {
          $widget.closest('form').submit();
          $widget.data('has-changed', false);
        }
      }

      $widget.toggleClass('clicked');
      $widget.removeClass('open');

      $widget.find('select').change(function(){

        if (allSelected($combos)) {
          var month = parseInt($combos.filter('[id$="_2i"]').val());
          var year  = parseInt($combos.filter('[id$="_1i"]').val());
          var day   = parseInt($combos.filter('[id$="_3i"]').val());
          if (day < 10) day = "0" + day;
          if (month < 10) month = "0" + month;

          $(this).parents(".combo_date").find("p:eq(0)").html(month + "/" + day + "/" + year);
        }

        $widget.data('has-changed', true);

      });

    });

    $combos.each(function(){
      var width = {}
        , $this = $(this)
        , id = $this.attr('id')
        , combo_type = /.*_(\di)/.exec(id)[1]
        ;

      width[$(this).attr('id') + '_chzn'] = combos_widths[combo_type];

      $(this).chosen({
        widths: width,
        hide_search: true
      });

      var $chosen_combo = $this.next('.chzn-container');
      $chosen_combo.click(function(e){
        $combos.not($this).each(function(){
          $(this).data('chosen').close_field();
        });
      });

      //$(this).click(function(evt){
        //console.log(evt);
      //});

    });

    $(document).click(function(event) {
      if ($widget.hasClass('clicked')) {

        $widget.not(event.target).removeClass('clicked');

        if (options.submitOnChange && $widget.data('has-changed') && allSelected($combos)) {
          $widget.closest('form').submit();
          $widget.data('has-changed', false);
        }
      }
    });

  })

});
