

    function IOMMarker(info, diameter, image, map) {
      // this.latlng_ = new google.maps.LatLng(info.lat,info.lon);
	  this.latlng_ = new google.maps.LatLng(parseFloat(info.lat),parseFloat(info.lon));
      this.url = info.url;
      this.count = info.count;
      this.total_in_region = info.total_in_region;
      this.image = image;
    	this.map_ = map;
    	this.name = info.name;
    	this.diameter = diameter;


      this.offsetVertical_ = -(this.diameter/2);
      this.offsetHorizontal_ = -(this.diameter/2);
      this.height_ = this.diameter;
      this.width_ = this.diameter;

      this.setMap(map);
    }

    IOMMarker.prototype = new google.maps.OverlayView();

    IOMMarker.prototype.draw = function() {

      var me = this;
    	var num = 0;

      var div = this.div_;
      if (!div) {
        div = this.div_ = document.createElement('div');
        div.style.border = "none";
        div.style.position = "absolute";
    		div.style.width = this.diameter + 'px';
    		div.style.height = this.diameter + 'px';
    		div.style.zIndex = 1;
        div.style.cursor = "pointer";

    		//Marker image
        var marker_image = document.createElement('img');
        marker_image.style.position = "relative";
        marker_image.style.width = "100%";
        marker_image.style.height = "100%";
        marker_image.src = this.image;
        div.appendChild(marker_image);

    		try {
    		  if (show_regions_with_one_project!=undefined) {
            var count = document.createElement('p');
            count.style.position = "absolute";
            count.style.top = "50%";
            count.style.left = "50%";
            count.style.height = "15px";
            count.style.textAlign = "center";
            if (this.diameter==20) {
              count.style.margin ="-6px 0 0 0px";
              count.style.font = "normal 10px Arial";
            } else if (this.diameter==26) {
              count.style.margin ="-6px 0 0 0px";
              count.style.font = "normal 11px Arial";
            } else if (this.diameter==34) {
              count.style.margin ="-7px 0 0 0px";
              count.style.font = "normal 12px Arial";
            } else if (this.diameter==42) {
              count.style.margin ="-7px 0 0 0px";
              count.style.font = "normal 15px Arial";
            } else {
              count.style.margin ="-9px 0 0 0px";
              count.style.font = "normal 18px Arial";
            }
            count.style.color = "white";
            $(count).text(this.count);
            div.appendChild(count);
          }
    		} catch(e) {
    		  if(this.count>1) {
              var count = document.createElement('p');
              count.style.position = "absolute";
              count.style.top = "50%";
              count.style.left = "50%";
              count.style.height = "15px";
              count.style.textAlign = "center";
              if (this.diameter==20) {
                count.style.margin ="-6px 0 0 0px";
                count.style.font = "normal 10px Arial";
              } else if (this.diameter==26) {
                count.style.margin ="-6px 0 0 0px";
                count.style.font = "normal 11px Arial";
              } else if (this.diameter==34) {
                count.style.margin ="-7px 0 0 0px";
                count.style.font = "normal 12px Arial";
              } else if (this.diameter==42) {
                count.style.margin ="-7px 0 0 0px";
                count.style.font = "normal 15px Arial";
              } else {
                count.style.margin ="-9px 0 0 0px";
                count.style.font = "normal 18px Arial";
              }
              count.style.color = "white";
              $(count).text(this.count);
              div.appendChild(count);
          }
    		}

        //Marker address
        if (map_type=="overview_map" || map_type=="administrative_map") {

          var hidden_div = document.createElement('div');
          hidden_div.style.border = "none";
          hidden_div.style.position = "absolute";
          hidden_div.style.margin = "0px";
          hidden_div.style.padding = "0px";
          hidden_div.style.display = "none";
          hidden_div.style.bottom = this.diameter + 4 +"px";
          hidden_div.style.left = (this.diameter/2)-(175/2)+"px";
          hidden_div.style.width = '175px';

          try {
          if (kind!=null) {
            var top_hidden = document.createElement('div');
            top_hidden.style.border = "none";
            top_hidden.style.position = "relative";
            top_hidden.style.float = "left";
            top_hidden.style.padding = "9px 15px 3px 11px";
            top_hidden.style.width = '149px';
            top_hidden.style.height = 'auto';
            top_hidden.style.background = "url('/images/sites/common/tooltips/body_tooltip.png') no-repeat center top";
            top_hidden.style.font = "bold 17px 'PT Sans'";
            top_hidden.style.textAlign = "center";
            top_hidden.style.color = "white";
            if (kind=="sector" || kind=="cluster") {
              $(top_hidden).html(this.name+'<br/><strong style="font:normal 13px Arial; color:#dddddd">'+this.count+ ((this.count>1)?' projects in this '+kind:' project in this '+kind)+'</strong><br/><strong style="font:normal 12px Arial; color:#999999">'+this.total_in_region+' in total</strong>');
            } else {
              $(top_hidden).html(this.name+'<br/><strong style="font:normal 13px Arial; color:#dddddd">'+this.count+ ((this.count>1)?' projects by this '+kind:' project by this '+kind)+'</strong><br/><strong style="font:normal 12px Arial; color:#999999">'+this.total_in_region+' in total</strong>');
            }
            hidden_div.appendChild(top_hidden);
          }} catch (e) {
            var top_hidden = document.createElement('div');
            top_hidden.style.border = "none";
            top_hidden.style.position = "relative";
            top_hidden.style.float = "left";
            top_hidden.style.padding = "9px 15px 3px 11px";
            top_hidden.style.width = '149px';
            top_hidden.style.height = 'auto';
            top_hidden.style.background = "url('/images/sites/common/tooltips/body_tooltip.png') no-repeat center top";
            top_hidden.style.font = "bold 17px 'PT Sans'";
            top_hidden.style.textAlign = "center";
            top_hidden.style.color = "white";
            $(top_hidden).html(this.name+'<br/><strong style="font:normal 13px Arial; color:#999999">'+this.count+ ((this.count>1)?' projects':' project')+'</strong>');
            hidden_div.appendChild(top_hidden);
          }


          var bottom_hidden = document.createElement('div');
          bottom_hidden.style.border = "none";
          bottom_hidden.style.position = "relative";
          bottom_hidden.style.float = "left";
          bottom_hidden.style.background = "url('/images/sites/common/tooltips/bottom_tooltip.png') no-repeat 0 0";
          bottom_hidden.style.width = '175px';
          bottom_hidden.style.height = '14px';
          hidden_div.appendChild(bottom_hidden);

          div.appendChild(hidden_div);

          google.maps.event.addDomListener(div,'mouseover',function(ev){
            $(this).css('zIndex',global_index++);
            $(this).children('div').show();
          });

          google.maps.event.addDomListener(div,'mouseout',function(ev){
            $(this).children('div').hide();
          });
        } else {
          google.maps.event.addDomListener(div,'mouseover',function(ev){
            $(this).css('zIndex',global_index++);
          });
        }




          google.maps.event.addDomListener(div,'click',function(ev){
      	    try{
      				ev.stopPropagation();
      			}catch(e){
      				event.cancelBubble=true;
      			};

      			if (me.url!=undefined && me.url!=window.location.pathname +window.location.search) {

              if (typeof MAP_EMBED != 'undefined' && MAP_EMBED){
                window.open(
                  me.url,
                  '_blank'
                );
              } else {
                window.location.href=me.url;
              }
    			  } else {
    			    $('html,body').animate({
              scrollTop: $("#projects_div").offset().top
              }, 1000);
    			  }
      	  });


    		google.maps.event.addDomListener(div,'mousedown',function(ev){
    	    try{
    				ev.stopPropagation();
    			}catch(e){
    				event.cancelBubble=true;
    			};
    	  });





        var panes = this.getPanes();
        panes.floatPane.appendChild(div);


        if (($(this.div_).children('p').width()+6)>this.width_) {
          $(this.div_).children('p').css('display','none');
        } else {
          $(this.div_).children('p').css('margin-left',-($(this.div_).children('p').width()/2) + "px");
        }

      }

    	var pixPosition = me.getProjection().fromLatLngToDivPixel(me.latlng_);
      if (pixPosition) {
    	  div.style.width = me.width_ + 'px';
    	  div.style.left = (pixPosition.x + me.offsetHorizontal_) + 'px';
    	  div.style.height = me.height_ + 'px';
    	  div.style.top = (pixPosition.y + me.offsetVertical_) + 'px';
      }

    };

    IOMMarker.prototype.remove = function() {
      if (this.div_) {
        this.div_.parentNode.removeChild(this.div_);
        this.div_ = null;
      }
    };

    IOMMarker.prototype.hide = function() {
      if (this.div_) {
        $(this.div_).find('div').fadeOut();
      }
    };
