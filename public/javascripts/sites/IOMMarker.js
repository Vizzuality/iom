

    function IOMMarker(info, style, map) {
      this.latlng_ = new google.maps.LatLng(info.lat,info.lon);
      this.url = info.url;
      this.count = info.count;
      this.color = style;
    	this.map_ = map;
    	this.name = info.name;

      this.offsetVertical_ = -18;
      this.offsetHorizontal_ = -18;
      this.height_ = 36;
      this.width_ = 36;

      this.setMap(map);
    }

    IOMMarker.prototype = new google.maps.OverlayView();

    IOMMarker.prototype.draw = function() {
				
      var me = this;
    	var num = 0;

      var div = this.div_;
      if (!div) {
        div = this.div_ = document.createElement('DIV');
        div.style.border = "none";
        div.style.position = "absolute";
    		div.style.width = '36px';
    		div.style.height = '36px';
    		$(div).css('-webkit-border-radius','20px');
    		div.style.background = this.color;
    		
        //Marker address
        var count = document.createElement('p');
        count.style.position = "relative";
        count.style.width = "100%";
        count.style.textAlign = "center";
        count.style.margin = "10px 0 0 0";
        count.style.font = "normal 15px 'PT Sans Bold'";
        count.style.color = "white";
        $(count).text(this.count);
        div.appendChild(count);


        //         var hidden_div = document.createElement('DIV');
        //         hidden_div.style.border = "none";
        //         hidden_div.style.position = "absolute";
        //        hidden_div.style.margin = "0px";
        //        hidden_div.style.padding = "0px";
        //        hidden_div.style.display = "none";
        //        hidden_div.style.top = "-118px";
        //        hidden_div.style.left = "-92px";
        //        hidden_div.style.width = '205px';
        //        hidden_div.style.height = '124px';
        //        hidden_div.style.background = 'url("/wp-content/themes/CDBetisSanIsidro/images/common/infowindow.png") no-repeat 0 0';
        // 
        //         
        //         
        //         //Marker stadium
        // var stadium = document.createElement('p');
        // $(stadium).addClass('accuracy');
        // stadium.style.position = "relative";
        //        stadium.style.width = "150px";
        // stadium.style.margin = "25px 0 0 25px";
        // stadium.style.font = "bold 18px Arial";
        // stadium.style.color = "#666666";
        // $(stadium).text(this.name);
        // hidden_div.appendChild(stadium);
        // 
        // 
        // //Marker address
        // var address = document.createElement('p');
        //        address.style.position = "relative";
        //        address.style.width = "155px";
        // address.style.margin = "5px 0 0 25px";
        // address.style.font = "normal 13px Arial";
        // address.style.color = "#666666";
        // $(address).text(this.name);
        // hidden_div.appendChild(address);


        google.maps.event.addDomListener(div,'click',function(ev){ 
    	    try{
    				ev.stopPropagation();
    			}catch(e){
    				event.cancelBubble=true;
    			};
    			window.location.href=me.url;
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
