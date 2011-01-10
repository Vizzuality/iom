(function($) {  
    
	var self = null;
 	
	$.fn.liveUpdate = function(list) {	
		return this.each(function() {
			new $.liveUpdate(this, list);
		});
	};
	
	$.liveUpdate = function (e, list) {
		this.field = $(e);
		this.list  = $('#' + list);
		if (this.list.length > 0) {
			this.init();
		}
	};
	
	$.liveUpdate.prototype = {
		init: function() {
			var self = this;
			this.setupCache();
			this.field.parents('form').submit(function() { return false; });
			this.field.keyup(function() { self.filter(); });
			self.filter();
		},
		
		filter: function() {
			if ($.trim(this.field.val()) == '') { this.list.find('li').children('a').show(); return; }
			this.displayResults(this.getScores(this.field.val().toLowerCase()));
		},
		
		setupCache: function() {
			var self = this;
			this.cache = [];
			this.rows = [];
			this.list.find('li').each(function() {
				self.cache.push(this.innerHTML.toLowerCase());
				self.rows.push($(this));
			});
			this.cache_length = this.cache.length;
		},
		
		displayResults: function(scores) {
			var self = this;
			this.list.find('li').hide();
			$.each(scores, function(i, score) { self.rows[score[1]].show(); });
			
			var element = this.list;

			if (element.length >0){
                var api = element.data('jsp');
                api.reinitialise();				
            }else {
				this.list.find('p.no_founded').css('display','inline');			
			}
			
			if (scores.length > 0){
				this.list.find('p.no_founded').css('display','none');
			}else {
				this.list.find('p.no_founded').css('display','inline');
			}		
		},
		getScores: function(term) {
			var scores = [];
	
			for (var i=0; i < this.cache_length; i++) { 
			    
                var score = this.cache[i].contains(term) ;
                if (score > 0) { 				
					scores.push([score, i]); 
				}

					

			    // If we'd rather a "quicksilver search"
                // var score = this.cache[i].score(term);
                // if (score > 0) { scores.push([score, i]); }
			}
			return scores.sort(function(a, b) { return b[0] - a[0]; });
		}
	}
})(jQuery);