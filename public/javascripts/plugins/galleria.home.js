/*
 * Galleria Classic Theme v. 1.5 2010-10-28
 * http://galleria.aino.se
 *
 * Copyright (c) 2010, Aino
 * Licensed under the MIT license.
 */

(function($) {

  Galleria.addTheme({
    name: 'home',
    author: 'Vizzuality',
    version: '1.5',
    css: '../../stylesheets/sites/galleria.home.css',
    defaults: {
      transition: 'slide',
      thumb_crop: 'height',

      // set this to false if you want to show the caption all the time:
      _toggle_info: false
  },
  init: function(options) {

    // cache some stuff
    var toggle   = this.$('image-nav-left,image-nav-right'),
        info     = this.$('info-text'),
        click    = Galleria.TOUCH ? 'touchstart' : 'click';

  // show loader & counter with opacity
  this.$('loader').show().css('opacity',.8)
  this.$('counter').css('display','none');
  this.$('galleria-info').css('display','none');
  // some stuff for non-touch browsers
  if (! Galleria.TOUCH ) {
    // fade thumbnails
    this.$('thumbnails').children().hover(function() {
      $(this).not('.active').children().stop().fadeTo(100, 1);
    }, function() {
      $(this).not('.active').children().stop().fadeTo(400, .6);
    });

    // this.addIdleState( this.get('image-nav-left'), { left:-69 });
    // this.addIdleState( this.get('image-nav-right'), { right:-69 });
  }

  // bind some stuff
  this.bind(Galleria.THUMBNAIL, function(e) {
    $(e.thumbTarget).parent(':not(.active)').children().css('opacity',.6)
  });

  this.bind(Galleria.LOADSTART, function(e) {
    if (!e.cached) {
      this.$('loader').show().fadeTo(200, .8);
      // this.$('galleria-info').show().fadeTo(200, .0);
    }
    this.$('info').toggle( this.hasInfo() );
    $(e.thumbTarget).css('opacity',1).parent().siblings().children().css('opacity',.6);
  });
  this.bind(Galleria.LOADFINISH, function(e) {
    this.$('thumbnails-container').animate({opacity:1},1000);
    this.$('loader').fadeOut('fast');
    this.$('galleria-info').css('display','inline');
    // this.$('galleria-info').show().css('opacity',.8);
    info.show().fadeTo(200, 1);
  });
  }
  });

})(jQuery);
