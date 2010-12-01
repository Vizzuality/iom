$(document).ready(function(ev){

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
      $('li#gc_limited_country').find('span.select_country_combo').live('click',function(ev){
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

        ev.stopPropagation();
        ev.preventDefault();

        var id = $(this).children('a').attr('id');
        var name = $(this).children('a').text();

        $('input#site_project_context_organization_id').val(id);
        $('span.select_combo_typology').find('p.ngo').text(name);
        $('span.select_combo_typology.clicked').removeClass('clicked');

      });

});
