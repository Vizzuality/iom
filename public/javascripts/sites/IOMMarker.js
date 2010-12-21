

    function IOMMarker(info, total, image, map) {
      this.latlng_ = new google.maps.LatLng(info.lat,info.lon);
      this.url = info.url;
      this.count = info.count;
      this.image = image;
    	this.map_ = map;
    	this.name = info.name;
    
    	
    	this.diameter = (60*parseInt(this.count))/total;
    	
    	if (this.diameter<5) {
    	  this.diameter = 5;
    	}

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
    		
    		//Marker image
        var marker_image = document.createElement('img');
        marker_image.style.position = "relative";
        marker_image.style.width = "100%";
        marker_image.style.height = "100%";
        marker_image.src = this.image;
        div.appendChild(marker_image);
    		
        //Marker address
        if (this.height_>20) {
          var count = document.createElement('p');
          count.style.position = "absolute";
          count.style.top = "50%";
          count.style.left = "50%";
          count.style.height = "15px";
          count.style.margin ="-9px 0 0 0px";
          count.style.textAlign = "center";
          count.style.font = "normal 15px Arial";
          count.style.color = "white";
          $(count).css('text-shadow',"0 1px #204E2D");
          $(count).text(this.count);
          div.appendChild(count);
          

        }



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

        //div.appendChild(hidden_div);



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

        
        if ($(this.div_).children('p').width()>this.width_) {
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
