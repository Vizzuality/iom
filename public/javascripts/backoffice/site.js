$(document).ready(function(ev){
    
    /************** ADMIN PAGE - INIT (GET PARAMETERS)  ************************** */
    // console.log('country '+ $('select#gc_limited_country_section').val());
    // console.log('bbox '+ $('input#site_geographic_boundary_box').val());
    // console.log('cluster or sector '+ $('input#site_project_context_cluster_id').val());
    // console.log('organization '+ $('input#site_project_context_organization_id').val());   
    // console.log('tags '+ $('input#pc_tags_section').val());         
    
    
    // REMOVE SELECTED STYLE (CHECKBOX)
    if (!$('input#site_project_context_cluster_id').val()){
        $('li#include_sector_cluster').removeClass('selected');
    }
    if (!$('input#site_project_context_organization_id').val()){
        $('li#include_ngo').removeClass('selected');
    }
    else {
        var id_org = $('input#site_project_context_organization_id').val();
        var name = $('ul.organizations').find('a#'+id_org).text();
        $('li#include_ngo').find('p.ngo').text(name);
    }
    if (!$('input#pc_tags_section').val()){
        $('li#include_tags').removeClass('selected');
    }

    
    // CLEANING TYPOLOGY
    if ($('span.select_combo_typology').length > 0){
        var text = '';
        var id = '';
        if ($('input#site_project_context_cluster_id').val()){
            id = $('input#site_project_context_cluster_id').val();
            text = $('ul.clusters_or_sectors').find('a#'+ id+ '.cluster_value').text();
    
        }else if ($('input#site_project_context_sector_id').val()){
            id = $('input#site_project_context_sector_id').val();
            text = $('ul.clusters_or_sectors').find('a#'+ id+ '.sector_value').text();
        }else {
            text = 'Select a cluster or a sector';
        }
        $('p.cluster_sector').text(text);
        
        
        
    }
    /************** SITE PAGE  ************************** */
		if ($('select').length) {
  	  $('select#gc_limited_country_section').sSelect({ddMaxWidth: '245px',ddMaxHeight:'231px',containerClass:'country'});
		}

        if ($('input#site_project_classification').length > 0){
            var id_option = $('input#site_project_classification').val();
            $('div#classification_option').find('span a.clicked').removeClass('clicked');
            $('div#classification_option').find('span a#'+id_option+'').addClass('clicked');
        }

      // click on limited options
      $('ul.geographic_options').children('li').children('a.limited').click(function(ev){
        ev.stopPropagation();
        ev.preventDefault();

        if (!$(this).parent().hasClass('selected')){
          var id = $('ul.geographic_options').children('li.selected').attr('id');

          // IF "selected" - before was...
          switch(id){
            case 'gc_limited_region':
                $('select#gc_limited_country_section option:selected').val(null);
                $('li.selected').find('.selectedTxt').text('Select a country');
              break;
            case 'gc_limited_bbox':
              $('input#site_geographic_boundary_box').val('');
              break;
            default:

          };

          $('ul.geographic_options').children('li.selected').removeClass('selected');
          $(this).parent().addClass('selected');
        }
      });

       $(document).click(function(event) {
          // To change clicked style on country combo
          if (!$(event.target).closest('ul.newListSelected.country').length) {
              $('li#gc_limited_region').find('div.newListSelFocus').removeClass('newListSelFocus');
              $('li#gc_limited_region').find('div.newListSelected').css('background-position','0 0');
          };
        });

 
      // click on country combo (LIMITED TO A REGION)
      $('li#gc_limited_region').find('span.select_country_combo').live('click',function(ev){
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
      $('div.values.region').find('li').live('click',function(ev){
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
          $(this).parent().find('input').val('');
        
          // RESET VALUES
          var id = $(this).parent().attr('id');
          if (id == 'include_sector_cluster'){
            $('input#site_project_context_cluster_id').val(null);
            $('input#site_project_context_sector_id').val(null);
            $(this).parent().find('p.cluster_sector').text('Select a cluster or a sector');
          }else if (id == 'include_ngo'){
            $('input#site_project_context_organization_id').val(null);
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
        if ($(this).hasClass('clicked')) {
            $(this).removeClass('clicked');
        }else {
            $('span.select_combo_typology.clicked').removeClass('clicked');
            $(this).addClass('clicked');

            resetCombo($(this));

            $(document).click(function(event) {
              if (!$(event.target).closest('span.select_combo_typology').length) {
                $('span.select_combo_typology').removeClass('clicked');
              };
            });
        }
      });

      // CLICK ON SECTORS OR CLUSTER
      $('span.select_combo_typology').find('div.values').find('ul.clusters_or_sectors').find('li').click(function(ev){

        ev.stopPropagation();
        ev.preventDefault();

        var id = $(this).children('a').attr('id');
        var name = $(this).children('a').text();

        if ($(this).children('a').hasClass('cluster_value')){
          $('input#site_project_context_cluster_id').val(id);
          $('input#site_project_context_sector_id').val('');
        }else if ($(this).children('a').hasClass('sector_value')){
          $('input#site_project_context_sector_id').val(id);
          $('input#site_project_context_cluster_id').val('');          
        }
        $('span.select_combo_typology.clicked').removeClass('clicked');
        $('span.select_combo_typology').find('p.cluster_sector').text(name);
      });

      // CLICK ON ORGANIZATION
      $('span.select_combo_typology').find('ul.organizations').find('li').click(function(ev){

        ev.stopPropagation();
        ev.preventDefault();

        var id = $(this).children('a').attr('id');
        var name = $(this).children('a').text();

        $('input#site_project_context_organization_id').val(id);
        $('span.select_combo_typology').find('p.ngo').text(name);
        $('span.select_combo_typology.clicked').removeClass('clicked');

      });
});

// AUTOCOMPLETE TAGS

$(function() {
function split( val ) {
  return val.split( /,\s*/ );
}

    $('#gc_limited_country_section').change(function(){

      $.ajax({
        url: '/admin/regions?country_id=' + $(this).val()
      });
    });

  $("#pc_tags_section").autocomplete({
    style: 'site_tags',
    source: function( request, response ) {
      $('span.tags_site').addClass('active');
      var value = $("#pc_tags_section").val();
      if (value.indexOf(',') != -1 ) {
        value = value.substring(value.indexOf(',')+1, value.length);
      }
      $.ajax({
        url: '/admin/tags?term=' + value,
        dataType: "json",
        success: function( data ) {
          if(data != null) {
            response($.map(data, function(tag) {
              return {
                label: tag.name,
                value: tag.name
              }
            }));
          }
        }
      });
    },
    minLength: 2,
    focus: function() {
      // prevent value inserted on focus
      return false;
    },
    select: function( event, ui ) {
      var terms = split( this.value );
      // remove the current input
      terms.pop();
      // add the selected item
      terms.push( ui.item.value );
      // add placeholder to get the comma-and-space at the end
      terms.push( "" );
      this.value = terms.join( ", " );
      return false;
    },
    refresh: function(){
       this.element.children("li.ui-menu-item:odd a").addClass("ui-menu-item-alternate");
    }
  });
});
