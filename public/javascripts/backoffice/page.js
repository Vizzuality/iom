
    var htmlArea;

    $(document).ready( function() {

      //$("#txtDefaultHtmlArea").htmlarea();

      $("#txtDefaultHtmlArea").htmlarea({
          // Override/Specify the Toolbar buttons to show
          toolbar: [
              ["bold", "italic", "underline", "|", "forecolor"],
              ["p","h1", "h2", "h3", "h4", "h5", "h6"],
              ["orderedlist", "unorderedlist"],
              ["link", "unlink", "|", "image"]
          ],
          css: "/stylesheets/backoffice/htmlArea.css",
          loaded: function() {
              htmlArea = this;
          }
      });

      $('iframe').removeAttr('style');
      $('iframe').css('width',"548px");
      $('iframe').css('height',"687px");
      $('iframe').css('padding',"5px 8px");
      $('iframe').css('background-image',"url('/images/backoffice/pages/textarea_bkg_2.jpg')");
      $('iframe').css('border',"none");
      $('iframe').css('background-position',"0 0!important");

      $('a#show_html').click(function(ev){
        ev.preventDefault();
        ev.stopPropagation();
        if ($('div.jHtmlArea div').is(':visible')) {
          $('div.jHtmlArea div').hide();
          $('div.jHtmlArea textarea').text(htmlArea.toHtmlString());
          $('div.jHtmlArea textarea').show();
          $(this).text('Show Editor');
        } else {
          $('div.jHtmlArea textarea').hide();

          $('div.jHtmlArea div').show();
          $(this).text('Show HTML');
        }
      });

      //Parent page combo
      $('span#parent_page').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();
        if (!$(this).hasClass('clicked')){
          $(this).addClass('clicked');
        }else {
          $(this).removeClass('clicked');
        }
        $(document).click(function(event) {
          if (!$(event.target).closest('span.parent_page').length) {
            $('span.parent_page.clicked').removeClass('clicked');
          };
        });
      });

      $("select#page_parent_id option:selected").each(function(index,element){
        $('span#parent_page p').attr('id',$(element).attr('value'));
        $('span#parent_page p').text($(element).text());
      });


      $('span#parent_page ul.options li').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();
        var id_ = $(this).children('a').attr('id');
        $('span#parent_page').children('p').text($(this).children('a').text());
        $('span#parent_page').children('p').attr('id',$(this).children('a').attr('id'));
        $('span#parent_page.clicked').removeClass('clicked');
        $('#page_parent_id option').attr('selected', false);
        $('#page_parent_id option').each(function(index,element){
          if ($(element).attr('value')==id_) {
            $(element).attr('selected','selected');
          }
        });
      });

      if ($('a.combo').length > 0){
          $('a.combo').click(function(ev){
             if (!$(this).hasClass('clicked')){
                 $('a.combo.clicked').removeClass('clicked');
                 $(this).addClass('clicked');
             }
             $('input#page_published').val($(this).attr('id'));
          });
      }
    });
