var old_value;


$(document).ready(function(ev){

		if ($('div.select_dates').length > 0){
			// YEAR
			$('select#project_start_date_1i').sSelect({ddMaxWidth: '76px',ddMaxHeight:'200px',containerClass:'year'});
			// MONTH
			$('select#project_start_date_2i').sSelect({ddMaxWidth: '131px',ddMaxHeight:'200px',containerClass:'month'});
			// DAY
			$('select#project_start_date_3i').sSelect({ddMaxWidth: '62px',ddMaxHeight:'200px',containerClass:'day'});

			// YEAR
			$('select#project_end_date_1i').sSelect({ddMaxWidth: '76px',ddMaxHeight:'200px',containerClass:'year'});
			// MONTH
			$('select#project_end_date_2i').sSelect({ddMaxWidth: '131px',ddMaxHeight:'200px',containerClass:'month'});
			// DAY
			$('select#project_end_date_3i').sSelect({ddMaxWidth: '62px',ddMaxHeight:'200px',containerClass:'day'});

			
			$('a.save_date_bttn.provided').click(function(ev){
				ev.stopPropagation();
				ev.preventDefault();

				var year = $('select#project_start_date_1i option:selected').val();
				var month = $('select#project_start_date_2i option:selected').val();
				var day = $('select#project_start_date_3i option:selected').val();
				
				var dateValue = day + '/' + month + '/' + year;
				$('span#date_provided').children('p').text(dateValue);
				$('span#date_provided').removeClass('clicked');				
			});
			
			$('a.save_date_bttn.updated').click(function(ev){
				ev.stopPropagation();
				ev.preventDefault();

				var year = $('select#project_start_date_1i option:selected').val();
				var month = $('select#project_start_date_2i option:selected').val();
				var day = $('select#project_start_date_3i option:selected').val();
				
				var dateValue = day + '/' + month + '/' + year;
				$('span#date_updated').children('p').text(dateValue);
				$('span#date_updated').removeClass('clicked');
			});
			
		}
	

    if ($('div.right.menu').length>0) {
      setTimeout(function(){
        $('div.right.menu').height($('div.block div.med div.left').height());
        $('div.right.menu div.delete').show();
      },300);
    }

    //remove text from input
    $('input.main_search').focusin(function(ev){
      var value = $(this).attr('value');
      if (value == "Search donors by name, place,..." || value == "Search Organizations by name, place,..." || value == "Search projects by name, place,..." || value == "Search sites by name, place,...") {
        old_value = value;
        $(this).attr('value','');
      }
    });
    $('input.main_search').focusout(function(ev){
      var value = $(this).attr('value');
      if (value == "") {
        $(this).attr('value',old_value);
      }
    });


    //window alert -> delete something (NGO, donor, site, project or object)
    $('div.delete a, a.delete').click(function(ev){
      ev.stopPropagation();
      ev.preventDefault();
      var scroll_position = window.pageYOffset;
      var window_height = (typeof window.innerHeight != 'undefined' ? window.innerHeight : document.body.offsetHeight);
      $('div#modal_window').css('height',window_height+'px');
      $('div#modal_window').css('top',scroll_position+'px');
      $('body').css('overflow','hidden');
      $(window).resize(function() {
        var scroll_position = window.pageYOffset;
        var window_height = (typeof window.innerHeight != 'undefined' ? window.innerHeight : document.body.offsetHeight);
        $('div#modal_window').css('height',window_height+'px');
        $('div#modal_window').css('top',scroll_position+'px');
      });
      var href_ = $(this).attr('destroy_url');
      var name_ = $(this).attr('att_name');
      $('div#modal_window a.remove').attr('href','javascript: void removeAndGo("'+href_+'")');
      $('div#modal_window h4').text('You are about deleting this '+capitaliseFirstLetter(name_));
      $('div#modal_window p').text('If you delete this '+name_+', it will not appear in any site.');
      $('div#modal_window').fadeIn();
    });

    $('div#modal_window a.cancel').click(function(ev){
      ev.stopPropagation();
      ev.preventDefault();
      $(window).unbind('resize');
      $('body').css('overflow','auto');
      $('div#modal_window').fadeOut();
    });


    //change preview link if twitter/facebook/website changes
    $('input.website').change(function(ev){
      $('a#website').attr('href',$(this).attr('value'));
    });
    $('input.twitter').change(function(ev){
      $('a#twitter').attr('href','http://twitter.com/'+$(this).attr('value'));
    });
    $('input.facebook').change(function(ev){
      $('a#facebook').attr('href',$(this).attr('value'));
    });

    //if there is an error in some field
    $('a.error').hover(
      function() {
        $(this).parent().find('div.error_msg').show();
      }
    );
    $('div.error_msg p').hover(function(){},
      function() {
        $(this).parent().hide();
      }
    );

    //if there is an error in some field
    $('a.simple_error').hover(
      function() {
        $(this).parent().find('div.error_msg').show();
      }
    );


  // **************************************************** COMBOS
  //  combo status
  $('span#status_combo_search').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    if (!$(this).hasClass('clicked')){
      $('span.clicked').removeClass('clicked');
      $(this).addClass('clicked');
    }else {
      $('span.clicked').removeClass('clicked');
      $(this).removeClass('clicked');
    }

    $(document).click(function(event) {
      if (!$(event.target).closest('span#status_combo_search').length) {
        $('span#status_combo_search').removeClass('clicked');
      };
    });
  });

  $('span#status_combo_search').find('li').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
    var id = $(this).children('a').attr('id');
    var name = $(this).children('a').text();

    if ((id != undefined)&&(name != undefined)){
      $('span#status_combo_search').children('p').text(name);

      $('input#status_input').val(id);
      $('span#status_combo_search').removeClass('clicked');
    }
  });


  //  COMBO COUNTRY
  $('span#country_combo_search').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    if (!$(this).hasClass('clicked')){
      $('span.clicked').removeClass('clicked');
      $(this).addClass('clicked');
    }else {
      $('span.clicked').removeClass('clicked');
      $(this).removeClass('clicked');
    }

    $(document).click(function(event) {
      if (!$(event.target).closest('span#country_combo_search').length) {
        $('span#country_combo_search').removeClass('clicked');
      };
    });
  });

  $('span#country_combo_search').find('li').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
    var id = $(this).children('a').attr('id');
    var name = $(this).children('a').text();
    if ((id != undefined)&&(name != undefined)){
      $('span#country_combo_search').children('p').text(name);
      $('input#country_input').val(id);
      $('span#country_combo_search').removeClass('clicked');
    }
  });

  // END COUNTRY

  //  COMBO CLUSTER
  $('span#cluster_combo_search').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    if (!$(this).hasClass('clicked')){
      $('span.clicked').removeClass('clicked');
      $(this).addClass('clicked');
    }else {
      $('span.clicked').removeClass('clicked');
      $(this).removeClass('clicked');
    }

    $(document).click(function(event) {
      if (!$(event.target).closest('span#cluster_combo_search').length) {
        $('span#cluster_combo_search').removeClass('clicked');
      };
    });
  });

  $('span#cluster_combo_search').find('li').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
    var id = $(this).children('a').attr('id');
    var name = $(this).children('a').text();
    if ((id != undefined)&&(name != undefined)){
      $('span#cluster_combo_search').children('p').text(name);
      $('input#cluster_input').val(id);
      $('span#cluster_combo_search').removeClass('clicked');
    }
  });

  // END CLUSTER

  //  SECTOR CLUSTER
  $('span#sector_combo_search').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    if (!$(this).hasClass('clicked')){
      $('span.clicked').removeClass('clicked');
      $(this).addClass('clicked');
    }else {
      $('span.clicked').removeClass('clicked');
      $(this).removeClass('clicked');
    }

    $(document).click(function(event) {
      if (!$(event.target).closest('span#sector_combo_search').length) {
        $('span#sector_combo_search').removeClass('clicked');
      };
    });
  });

  $('span#sector_combo_search').find('li').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
    var id = $(this).children('a').attr('id');
    var name = $(this).children('a').text();
    if ((id != undefined)&&(name != undefined)){
      $('span#sector_combo_search').children('p').text(name);
      $('input#sector_input').val(id);
      $('span#sector_combo_search').removeClass('clicked');
    }
  });

  // END CLUSTER

  //  combo tags click
  $('div.list_combo').children('span.combo_large').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    if ($(this).attr('id') == 'hidden'){
      $('div.list_combo').find('ul.list_combo_content').css('display','inline');
      $(this).addClass('displayed');
      $(this).attr('id','visible');
    }else{
      $('div.list_combo').find('ul.list_combo_content').css('display','none');
      $(this).attr('id','hidden');
      $(this).removeClass('displayed');
    }

    $(document).click(function(event) {
      if (!$(event.target).closest('ul.list_combo_content').length) {
        $('div.list_combo').find('ul.list_combo_content').css('display','none');
        $('div.list_combo').children('span.combo_large').attr('id','hidden');
        $('div.list_combo').children('span.combo_large').removeClass('displayed');
      };
    });
  });

  $('ul.list_combo_content').find('li.element').click(function(ev){
    var id = $(this).attr('id');
    var name = $(this).children('p.project_name').text();

    $('input#project_primary_organization_id').val($(this).attr('id'));
    $('div.list_combo').find('a.organization').text(name);
    $('div.list_combo').find('ul.list_combo_content').css('display','none');
    $('div.list_combo').children('span.combo_large').attr('id','hidden');
    $('div.list_combo').children('span.combo_large').removeClass('displayed');
  });
  // end combo tags click

  $('span.combo_date').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    if (!$(this).hasClass('clicked')){
      $('span.combo_date.clicked').removeClass('clicked');
      $(this).addClass('clicked');
	  $(this).find('div.newListSelected').css('background-position','0 0');

    }

    $(document).click(function(event) {
      if (!$(event.target).closest('span.combo_date').length) {
        $('span.combo_date.clicked').removeClass('clicked');
      };
    });
  });

  /************** CLUSTERS ************************** */
  $('span.combo_cluster_options').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    if (!$(this).hasClass('clicked')){
      $(this).addClass('clicked');
    }else {
      $(this).removeClass('clicked');
    }

    $(document).click(function(event) {
      if (!$(event.target).closest('span.combo_cluster_options').length) {
        $('span.combo_cluster_options.clicked').removeClass('clicked');
      };
    });
  });

  // IF WE ADD SOME CLUSTER
  $('span.combo_cluster_options').find('ul.options li').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
    $('span.combo_cluster_options').children('p').text($(this).children('a').text());
    $('span.combo_cluster_options').children('p').attr('id',$(this).children('a').attr('id'));
    $('span.combo_cluster_options.clicked').removeClass('clicked');

  });

  // CLICK ON ADD CLUSTER
  $('a#add_cluster_bttn').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    var id = $('span.combo_cluster_options').children('p').attr('id');

    // If we have some element (id=0 is a simple control to test it)
    if (id != 0){
      var text = $('span.combo_cluster_options').children('p').text();

      var htmlToAdd = '<li id="cluster_'+id+'">'+text+'<input id="'+id+'"type="checkbox" name="project[clusters_ids][]" value="'+id+'" checked="true"" /><a id="'+id+'" class="remove_this close"></a></li>';

      $('ul.clusters').append(htmlToAdd);
      $('span.combo_cluster_options').children('p').text('Select more clusters');
      $('span.combo_cluster_options').children('p').attr('id','0');
    }
    });

  // CLICK ON REMOVE CLUSTER
  $('ul.clusters').find('a.remove_this').live('click',function(ev){
    $(this).parent().children('input#' + $(this).attr('id') +'').attr('checked',false);
    $(this).parent().remove();
  });


  /************** SECTORS ************************** */
  $('span#sector').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    if (!$(this).hasClass('clicked')){
      $(this).addClass('clicked');
    }else {
      $(this).removeClass('clicked');
    }

    $(document).click(function(event) {
      if (!$(event.target).closest('span.combo_sector_options').length) {
        $('span.combo_sector_options.clicked').removeClass('clicked');
      };
    });
  });

     // IF WE ADD SOME SECTOR
    $('span#sector').find('ul.options li').click(function(ev){
      ev.stopPropagation();
      ev.preventDefault();
      $('span#sector').children('p').text($(this).children('a').text());
      $('span#sector').children('p').attr('id',$(this).children('a').attr('id'));
      $('span#sector.clicked').removeClass('clicked');
    });

    // CLICK ON ADD SECTOR
    $('a.add_sector').click(function(ev){

      ev.stopPropagation();
      ev.preventDefault();

      var id = $('span#sector').children('p').attr('id');

      // If we have some element (id=0 is a simple control to test it)
      if (id != 0){
        var text = $('span#sector').children('p').text();
        var htmlToAdd = '<li id="sector_'+id+'">'+text+'<input id="'+id+'"type="checkbox" name="project[sectors_ids][]" value="'+id+'" checked="true"" /><a id="'+id+'" class="remove_this close"></a></li>';

        $('ul.sectors').append(htmlToAdd);
        $('span#sector').children('p').text('Select more sectors');
        $('span#sector').children('p').attr('id','0');
      }
      });

    // CLICK ON REMOVE SECTOR
    $('ul.sectors').find('a.remove_this').live('click',function(ev){
      $(this).parent().children('input#' + $(this).attr('id') +'').attr('checked',false);
      $(this).parent().remove();
    });

    /************** SUBSECTORS ************************** */
    $('span#subsector').click(function(ev){
      ev.stopPropagation();
      ev.preventDefault();

      if (!$(this).hasClass('clicked')){
        $(this).addClass('clicked');
      }else {
        $(this).removeClass('clicked');
      }

      $(document).click(function(event) {
        if (!$(event.target).closest('span#subsector').length) {
          $('span#subsector.clicked').removeClass('clicked');
        };
      });
    });

       // IF WE ADD SOME SECTOR
      $('span#subsector').find('ul.options li').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();
        $('span#subsector').children('p').text($(this).children('a').text());
        $('span#subsector').children('p').attr('id',$(this).children('a').attr('id'));
        $('span#subsector.clicked').removeClass('clicked');
      });

      // CLICK ON ADD SECTOR
      // $('a.add_sector').click(function(ev){
      //
      //   ev.stopPropagation();
      //   ev.preventDefault();
      //
      //   var id = $('span#sector').children('p').attr('id');
      //
      //   // If we have some element (id=0 is a simple control to test it)
      //   if (id != 0){
      //     var text = $('span#sector').children('p').text();
      //     var htmlToAdd = '<li id="sector_'+id+'">'+text+'<input id="'+id+'"type="checkbox" name="project[sectors_ids][]" value="'+id+'" checked="true"" /><a id="'+id+'" class="remove_this close"></a></li>';
      //
      //     $('ul.sectors').append(htmlToAdd);
      //     $('span#sector').children('p').text('Select more sectors');
      //     $('span#sector').children('p').attr('id','0');
      //   }
      //         });

      // CLICK ON REMOVE SECTOR
      // $('ul.sectors').find('a.remove_this').live('click',function(ev){
      //   $(this).parent().children('input#' + $(this).attr('id') +'').attr('checked',false);
      //   $(this).parent().remove();
      // });

      /************** SITE PAGE  ************************** */

      // click on limited options
      $('ul.geographic_options').children('li').children('a.limited').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();

        if (!$(this).parent().hasClass('selected')){
          var id = $('ul.geographic_options').children('li.selected').attr('id');

          // IF "selected" - before was...
          if (id == 'gc_limited_country'){
            $('input#geographic_context_country_id').val(null);
            $('li.selected').find('p.country').text('Select a country');

          }else  if (id == 'gc_limited_region'){
            $('input#geographic_context_country_id').val(null);
            $('input#geographic_context_region_id').val(null);
            $('li.selected').find('p.country').text('Select a country');
            $('li.selected').find('p.region').text('Select a region');
          }else if (id == 'gc_limited_bbox'){
            // TODO

          }

          $('ul.geographic_options').children('li.selected').removeClass('selected');
          $(this).parent().addClass('selected');
        }
      });

      // click on country combo (LIMITED TO A COUNTRY)
      $('li#gc_limited_country').find('span.select_country_combo').click(function(ev){

        ev.stopPropagation();
        ev.preventDefault();

        if (!$(this).hasClass('clicked')){
          $(this).addClass('clicked');
        }

        $(document).click(function(event) {
          if (!$(event.target).closest('span.select_country_combo').length) {
            $('li#gc_limited_country').find('span.select_country_combo').removeClass('clicked');
          };
        });
      });

      // SET VALUE IF CLICK ON COUNTRY
      $('div.values.country').find('li').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();
        var id = $(this).children('a').attr('id');
        var name = $(this).children('a').text();
        $('input#site_geographic_context_country_id').val(id);
        $('span.select_country_combo.clicked').children('p.country').text(name);
        $('span.select_country_combo.clicked').removeClass('clicked');
      });

      // click on country combo (LIMITED TO A REGION)
      $('li#gc_limited_region').find('span.select_country_combo').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();

        if (!$(this).hasClass('clicked')){
          $(this).addClass('clicked');
        }

        $(document).click(function(event) {
          if (!$(event.target).closest('span.select_country_combo').length) {
            $('li#gc_limited_region').find('span.select_country_combo').removeClass('clicked');
          };
        });
      });

      // SET VALUE IF CLICK ON REGION
      $('div.values.region').find('li').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();
        var id = $(this).children('a').attr('id');
        var name = $(this).children('a').text();
        $('input#site_geographic_context_region_id').val(id);
        $('span.select_country_combo.region.clicked').children('p.region').text(name);
        $('span.select_country_combo.region.clicked').removeClass('clicked');
      });


      // CLICK ON EACH OPTION (CHECKBOX)

      $('ul.project_tipo_options').children('li').children('a').click(function(ev){
        if ($(this).parent().hasClass('selected')){
          $(this).parent().removeClass('selected');

          // RESET VALUES
          var id = $(this).parent().attr('id');
          if (id == 'include_sector_cluster'){
            $('input#project_context_cluster_id').val(null);
            $('input#project_context_sector_id').val(null);
            $(this).parent().find('p.cluster_sector').text('Select a cluster or a sector');
          }else if (id == 'include_ngo'){
            $('input#project_context_organization_id').val(null);
            $(this).parent().find('p.ngo').text('Select an NGO');
          }else if (id == 'include_tags'){
            $('input#project_context_tags').val(null);
          }

        }else {
          $(this).parent().addClass('selected');
        }

      });

      // CLICK ON SELECT CLUSTER OR SECTOR
      $('span.select_combo_typology').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();

        $(this).addClass('clicked');

        $(document).click(function(event) {
          if (!$(event.target).closest('span.select_combo_typology').length) {
            $('span.select_combo_typology').removeClass('clicked');
          };
        });
      });

      // CLICK ON SECTORS OR CLUSTER
      $('span.select_combo_typology').children('div.values').children('ul.clusters_or_sectors').children('li').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();

        var id = $(this).children('a').attr('id');
        var name = $(this).children('a').text();

        if ($(this).children('a').hasClass('cluster_value')){
          $('input#site_project_context_cluster_id').val(id);
        }else if ($(this).children('a').hasClass('sector_value')){
          $('input#site_project_context_sector_id').val(id);
        }
        $('span.select_combo_typology.clicked').removeClass('clicked');
        $('span.select_combo_typology').find('p.cluster_sector').text(name);
      });

      // CLICK ON ORGANIZATION
      $('span.select_combo_typology').find('ul.organizations').children('li').click(function(ev){

        console.log('entra')
        ev.stopPropagation();
        ev.preventDefault();

        var id = $(this).children('a').attr('id');
        var name = $(this).children('a').text();

        $('input#site_project_context_organization_id').val(id);
        $('span.select_combo_typology').find('p.ngo').text(name);
        $('span.select_combo_typology.clicked').removeClass('clicked');

      });

});



 function capitaliseFirstLetter(string) {
     return string.charAt(0).toUpperCase() + string.slice(1);
 }


 function removeAndGo(location) {
   var form = $('<form method="post" action="'+location+'"></form>');
   var metadata_input = '<input name="_method" value="delete" type="hidden" />';
   form.hide()
       .append(metadata_input)
       .appendTo('body');
   form.submit();
 }
