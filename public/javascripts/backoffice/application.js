var old_value;

$(document).ready(function(ev){

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


    //window alert -> delete something (NGO, donor, site or project)
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

	$('span#status_combo_search').find('a').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		var id = $(this).attr('id');
		$('input#status_input').val(id);
		$('span#status_combo_search').removeClass('clicked');
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

	$('span#country_combo_search').find('a').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		var id = $(this).attr('id');
		$('input#country_input').val(id);
		$('span#country_combo_search').removeClass('clicked');
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

	$('span#cluster_combo_search').find('a').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		var id = $(this).attr('id');
		$('input#cluster_input').val(id);
		$('span#cluster_combo_search').removeClass('clicked');
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

	$('span#sector_combo_search').find('a').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		var id = $(this).attr('id');
		$('input#sector_input').val(id);
		$('span#sector_combo_search').removeClass('clicked');
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
		$('input#project_primary_organization_id').val($(this).attr('id'));
		
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
			// 	ev.stopPropagation();
			// 	ev.preventDefault();
			// 
			// 	var id = $('span#sector').children('p').attr('id');
			// 
			// 	// If we have some element (id=0 is a simple control to test it)
			// 	if (id != 0){
			// 		var text = $('span#sector').children('p').text();
			// 		var htmlToAdd = '<li id="sector_'+id+'">'+text+'<input id="'+id+'"type="checkbox" name="project[sectors_ids][]" value="'+id+'" checked="true"" /><a id="'+id+'" class="remove_this close"></a></li>';
			// 
			// 		$('ul.sectors').append(htmlToAdd);
			// 		$('span#sector').children('p').text('Select more sectors');
			// 		$('span#sector').children('p').attr('id','0');
			// 	}
			// 		  	});

			// CLICK ON REMOVE SECTOR
			// $('ul.sectors').find('a.remove_this').live('click',function(ev){
			// 	$(this).parent().children('input#' + $(this).attr('id') +'').attr('checked',false);
			// 	$(this).parent().remove();
			// });	
});
