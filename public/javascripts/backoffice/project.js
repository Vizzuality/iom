var old_value;

var limitTextCombo = 12;

// ID's
var orgs_id                  = 5; // orgs_
var clusters_id              = 9; // clusters_
var clusterToAdd             = 13; // clusterToAdd_
var sectors_id               = 8; // sectors_
var sectorToAdd              = 12; // sectorToAdd_
var organization_id          = 'XXXX';
var country_iso_codes         = [];
var current_year_last_digits = (new Date()).getFullYear().toString().substr(2, 2);
var project_id               = 'XXX';
$(document).ready(function(ev){

  $('div.long_search form.search select').change(function(){
    $(this).closest('form').submit();
  });
  // Field info
  $('div.field_info span.info').click(function(ev){
    ev.stopPropagation();

    $('div.field_info div.field_text').each(function(i,ele){
      $(ele).closest('label').removeAttr('style');
      $(ele).fadeOut('fast');
    });

    $(this).closest('label').css({'z-index':200});

    $('body').unbind('click');
    if ($(this).parent().find('div.field_text').is(':visible')) {
      $(this).closest('label').removeAttr('style');
      $(this).parent().find('div.field_text').fadeOut('fast');
    } else {
      $(this).parent().find('div.field_text').fadeIn('slow');
      $('body').click(function(ev){
        var $el = $(ev.target);
        if (!$el.closest('div.field_text').length>0) {
          $('div.field_info div.field_text').closest('label').removeAttr('style');
          $('div.field_info div.field_text').fadeOut('fast');
        }
      });
    }
  });
  $('div.field_info div.top a').click(function(ev){
    ev.preventDefault();
    ev.stopPropagation();
    $('div.field_info div.field_text').each(function(i,ele){
      $(ele).closest('label').removeAttr('style');
      $(ele).fadeOut('fast');
    });
  });

  // COUNTRY COMBO
  // $('select#country').sSelect({ddMaxWidth: '134px',ddMaxHeight:'220px',containerClass:'country_index'});

  // **************************************************** COMBOS
  //  combo status
  $('span#status_combo_search').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
    hideCountryCombo();
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

  //  COMBO CLUSTER
  $('span#cluster_combo_search').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    hideCountryCombo();

    if (!$(this).hasClass('clicked')){
      $('span.clicked').removeClass('clicked');
      $(this).addClass('clicked');
      resetCombo($(this));
    }else {
      $('span.clicked').removeClass('clicked');
      $(this).removeClass('clicked');
    }

    $(document).click(function(event) {
      if ((!$(event.target).closest('span#cluster_combo_search').length)&&(!$(event.target).closest('.scroll_pane').length)) {
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

      if (name.length > limitTextCombo) {
        name = name.substring(0,limitTextCombo - 3)+'...';
      }
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

    hideCountryCombo();

    if (!$(this).hasClass('clicked')){
      $('span.clicked').removeClass('clicked');
      $(this).addClass('clicked');
      resetCombo($(this));
    }else {
      $('span.clicked').removeClass('clicked');
      $(this).removeClass('clicked');
    }

    $(document).click(function(event) {
      if ((!$(event.target).closest('span#sector_combo_search').length)&&(!$(event.target).closest('.scroll_pane').length)) {
        $('span#sector_combo_search').removeClass('clicked');
      };
    });
  });

  $('span#sector_combo_search').find('li').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
    var id = $(this).children('a').attr('id');
    var name = $(this).children('a').text();

    if (name.length > limitTextCombo) {
      name = name.substring(0,limitTextCombo - 3)+'...';
    }

    if ((id != undefined)&&(name != undefined)){
      $('span#sector_combo_search').children('p').text(name);
      $('input#sector_input').val(id);
      $('span#sector_combo_search').removeClass('clicked');
    }
  });

  // END CLUSTER

  //  SITES COMBO
  $('span#site_combo_search').click(function(ev){

    ev.stopPropagation();
    ev.preventDefault();

    hideCountryCombo();

    if (!$(this).hasClass('clicked')){
      $('span.clicked').removeClass('clicked');
      $(this).addClass('clicked');
      resetCombo($(this));
    }else {
      $('span.clicked').removeClass('clicked');
      $(this).removeClass('clicked');
    }

    $(document).click(function(event) {
      if ((!$(event.target).closest('span#site_combo_search').length)&&(!$(event.target).closest('.scroll_pane').length)) {
        $('span#site_combo_search').removeClass('clicked');
      };
    });
  });

  $('span#site_combo_search').find('li').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
    var id = $(this).children('a').attr('id');
    var name = $(this).children('a').text();

    if (name.length > limitTextCombo) {
      name = name.substring(0,limitTextCombo - 3)+'...';
    }

    if ((id != undefined)&&(name != undefined)){
      $('span#site_combo_search').children('p').text(name);
      $('input#site_input').val(id);
      $('span#site_combo_search').removeClass('clicked');
    }
  });

  // END SITES COMBO
  //  combo tags click
  $('div.list_combo').children('span.combo_large').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    $('div.field_info div.field_text').each(function(i,ele){
      $(ele).closest('label').removeAttr('style');
      $(ele).fadeOut('fast');
    });

    if ($(this).attr('id') == 'hidden'){
      $('div.list_combo').find('ul.list_combo_content').css('display','inline');
      $(this).addClass('displayed');
      $(this).attr('id','visible');

      resetCombo($('div.list_combo'));
    }else{
      $('div.list_combo').find('ul.list_combo_content').css('display','none');
      $(this).attr('id','hidden');
      $(this).removeClass('displayed');
    }

    $(document).click(function(event) {
      if ((!$(event.target).closest('ul.list_combo_content').length)&&(!$(event.target).closest('.scroll_pane').length)) {
        $('div.list_combo').find('ul.list_combo_content').css('display','none');
        $('div.list_combo').children('span.combo_large').attr('id','hidden');
        $('div.list_combo').children('span.combo_large').removeClass('displayed');
      };
    });
  });

  // substring(0,10)+'...'

  $('ul.list_combo_content').find('li.element').click(function(ev){
    var id = $(this).attr('id');
    var name = $(this).children('p.project_name').text();
    id = id.substring(orgs_id,id.length);

    // id substring
    $('input#project_primary_organization_id').val(id);
    organization_id = organizations_ids[id];
    update_project_intervention_id();

    $('div.list_combo').find('a.organization').text(name);
    $('div.list_combo').find('ul.list_combo_content').css('display','none');
    $('div.list_combo').children('span.combo_large').attr('id','hidden');
    $('div.list_combo').children('span.combo_large').removeClass('displayed');
  });
  // end combo tags click
  $('input#project_organization_id').change(function(){
    project_id = $(this).val();
    update_project_intervention_id();
  });

  /************** CLUSTERS ************************** */
  $('span.combo_cluster_options').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    if (!$(this).hasClass('clicked')){

      // THIS IS A IE HACK
      $(this).css('position','relative');

      $(this).addClass('clicked');
      resetCombo($('span.combo_cluster_options'));
    }else {
      $(this).removeClass('clicked');
      $(this).css('position','static');
    }

    $(document).click(function(event) {
      if ((!$(event.target).closest('span.combo_cluster_options').length)&&(!$(event.target).closest('.scroll_pane').length)) {
        $('span.combo_cluster_options.clicked').removeClass('clicked');
        $('span.combo_cluster_options').css('position','static');
      };
    });
  });

  // IF WE ADD SOME CLUSTER
  $('span.combo_cluster_options').find('ul.options li').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
    $('span.combo_cluster_options').children('p').text($(this).children('a').text());
    var id = $(this).children('a').attr('id');
    id = id.substring(clusters_id,id.length);
    $('span.combo_cluster_options').children('p').attr('id','clusterToAdd_'+id);
    $('span.combo_cluster_options.clicked').removeClass('clicked');

  });

  // CLICK ON ADD CLUSTER
  $('a#add_cluster_bttn').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    var id = $('span.combo_cluster_options').children('p').attr('id');
    id = id.substring(clusterToAdd,id.length);

    var notAdded = false;
    notAdded = checkElementAdded($('ul.clusters'),id);

    // If we have some element (id=0 is a simple control to test it)
    if ((id != 0)&&(!notAdded)){
      var text = $('span.combo_cluster_options').children('p').text();

      var htmlToAdd = '<li id="cluster_'+id+'"><p>'+text+'</p><input id="'+id+'"type="checkbox" name="project[cluster_ids][]" value="'+id+'" checked="true"" /><a id="'+id+'" class="remove_this close"></a></li>';

      $('ul.clusters').append(htmlToAdd);
      $('span.combo_cluster_options').children('p').text('Select more clusters');
      $('span.combo_cluster_options').children('p').attr('id','clusterToAdd_0');
    }
    $('div.block div.med div.left').resize();
  });

  // CLICK ON REMOVE CLUSTER
  $('ul.clusters').find('a.remove_this').live('click',function(ev){
    $(this).parent().children('input#' + $(this).attr('id') +'').attr('checked',false);
    $(this).parent().remove();
    $('div.block div.med div.left').resize();
  });


  /************** SECTORS ************************** */
  $('span#sector').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();

    if (!$(this).hasClass('clicked')){
      $(this).css('position','relative');
      $(this).addClass('clicked');
      resetCombo($('span#sector'));
    }else {
      $(this).removeClass('clicked');
      $(this).css('position','static');
    }

    $(document).click(function(event) {
      if ((!$(event.target).closest('span.combo_sector_options').length)&&(!$(event.target).closest('.scroll_pane').length)) {
        $('span.combo_sector_options.clicked').removeClass('clicked');
        $('span#sector').css('position','static');
      };
    });
  });

  // IF WE ADD SOME SECTOR
  $('span#sector').find('ul.options li').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
    $('span#sector').children('p').text($(this).children('a').text());
    var id = $(this).children('a').attr('id');

    id = id.substring(sectors_id,id.length);
    $('span#sector').children('p').attr('id','sectorToAdd_'+id);
    $('span#sector.clicked').removeClass('clicked');
  });

  // CLICK ON ADD SECTOR
  $('a.add_sector').click(function(ev){

    ev.stopPropagation();
    ev.preventDefault();

    var id = $('span#sector').children('p').attr('id');
    id = id.substring(sectorToAdd,id.length);
    var notAdded = false;
    notAdded = checkElementAdded($('ul.sectors'),id);

    // If we have some element (id=0 is a simple control to test it)
    if ((id != 0)&&(!notAdded)){
      var text = $('span#sector').children('p').text();
      var htmlToAdd = '<li id="sector_'+id+'"><p>'+text+'</p><input id="'+id+'"type="checkbox" name="project[sector_ids][]" value="'+id+'" checked="true"" /><a id="'+id+'" class="remove_this close"></a></li>';

      $('ul.sectors').append(htmlToAdd);
      $('span#sector').children('p').text('Select more sectors');
      $('span#sector').children('p').attr('id','sectorToAdd_0');
    }
    $('div.block div.med div.left').resize();
  });

  // CLICK ON REMOVE SECTOR
  $('ul.sectors').find('a.remove_this').live('click',function(ev){
    $(this).parent().children('input#' + $(this).attr('id') +'').attr('checked',false);
    $(this).parent().remove();
    $('div.block div.med div.left').resize();
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
    $('div.block div.med div.left').resize();
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
  //     var htmlToAdd = '<li id="sector_'+id+'">'+text+'<input id="'+id+'"type="checkbox" name="project[sector_ids][]" value="'+id+'" checked="true"" /><a id="'+id+'" class="remove_this close"></a></li>';
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
    resetCombo($(this));
    $(document).click(function(event) {

      if (!$(event.target).closest('span.select_country_combo').length) {
        $('li#gc_limited_country').find('span.select_country_combo').removeClass('clicked');
      };
    });
    $('div.block div.med div.left').resize();
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
    resetCombo($(this));
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

    ev.stopPropagation();
    ev.preventDefault();

    var id = $(this).children('a').attr('id');
    var name = $(this).children('a').text();

    $('input#site_project_context_organization_id').val(id);
    $('span.select_combo_typology').find('p.ngo').text(name);
    $('span.select_combo_typology.clicked').removeClass('clicked');

  });

  // TO FIX IE7 BUG WITH Z-INDEX WE HAVE TO RESTORE Z-INDEX VALUES
  $('div.list_combo').css('zIndex', 200);
  $('div#implement_org').css('zIndex', 199);
  $('div#partner_org').css('zIndex', 198);
  $('ul.newList').css('zIndex', 197);

  $('div#cross_cutting').css('zIndex', 196);

  $('div#clusters_content').css('zIndex', 195);
  $('input#donation_submit').css('zIndex', 100);

  if (typeof floatingSubmit == 'function') {
    floatingSubmit($('form .submit'), $('div.main_layout div.block div.med div.right div.delete'));
  }

});

function checkElementAdded(list, id){
  var elementAdded = false;
  var id_li_element;

  $(list).children('li').each(function(index) {
    id_li_element = $(this).children('input').attr('id');

    if (id == id_li_element){
      elementAdded = true;
    }
  });
  return elementAdded;
}

function hideCountryCombo(){
  $('div.newListSelected').each(function() {
    $(this).css('background-position','0 0');
    $(this).css('zIndex',200);
    $('div.newList_content').find('ul').css('display','none');
    // $('div.country_index').css('display','none');
    $('div.newList_content').css('visibility','hidden');
    $('div.newList_content').find('ul').css('visibility','hidden');
  });
}

// AUTOCOMPLETE TAGS
$(function() {
  function split( val ) {
    return val.split( /,\s*/ );
  }


  if ($('#project_tags').length > 0){
    var custom_url =  '/admin/tags?term=';

    $("#project_tags").autocomplete({
      style: 'project_tags',
      source: function( request, response ) {
        $('span#tags_combo').addClass('active');
        var value = $("#project_tags").val();
        if (value.indexOf(',') != -1 ) {
          value = value.substring(value.indexOf(',')+1, value.length);
        }
        $.ajax({
          url: custom_url + value,
          dataType: "json",
          success: function( data ) {
            if(data != null) {
              response($.map(data, function(tag) {
                return {
                  label: tag.name + ' ' + tag.count + ' projects',
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
  }

  if ($('#autocomplete_donor_name').length > 0){
    var custom_donors_url = '/admin/donors?q=';

    // AUTOCOMPLETE FOR DONORS IN PROJECT
    $("#autocomplete_donor_name").autocomplete({
      style:'donor_names',
      source: function( request, response ) {
        var textbox = $('#autocomplete_donor_name');
        var value = $("#autocomplete_donor_name").val();
        textbox.next('.spinner').fadeIn('fast');
        $.ajax({
          url: custom_donors_url + value,
          dataType: "json",
          success: function( data ) {
            textbox.next('.spinner').fadeOut('fast');
            if(data != null) {
              response(data);
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
        $('#donation_donor_id').val(ui.item.element_id);
      },
      refresh: function(){
        this.element.children("li.ui-menu-item:odd a").addClass("ui-menu-item-alternate");
        console.log(this);
        $('span#donor_name_input').addClass('active');
      }
    });
  }

  $('span.combo_date:not(.disabled)').dateCombos();

  $('.chzn-container').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
  });

});

function update_project_intervention_id() {
  var project_intervention_id = organization_id + '-' +
                                (country_iso_codes.sort()[0] || 'XX') + '-' +
                                current_year_last_digits + '-' +
                                project_id;

  $('input#project_intervention_id.editable').val(project_intervention_id);
}

function updateCountryIsoCode(country_id) {
  country_iso_codes.push(countries_iso_codes[country_id]);
  update_project_intervention_id();
}

function removeCountryIsoCode(country_id) {
  var iso_code = countries_iso_codes[country_id];
  country_iso_codes.splice(country_iso_codes.indexOf(iso_code), 1)
  update_project_intervention_id();
}
