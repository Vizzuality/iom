$(document).ready( function() {

  // MENU CLICKS
  $('ul.menu li a').click(function(ev){
    
      ev.stopPropagation();
      ev.preventDefault();
      
      if (($(this).children('span.with_suboptions').length > 0)&&(!$(this).hasClass('displayed'))){

          // Close all tabs
          $('ul.menu li a.displayed').removeClass('displayed');          
          $('ul.menu li.clicked').removeClass('clicked');
          
          $(this).addClass('displayed');
          $(this).parent().addClass('clicked');
          $(document).click(function(event) {
            if (!$(event.target).closest('ul.menu li a').length) {
              $('ul.menu li.clicked').removeClass('clicked');                
              $('ul.menu li a.displayed').removeClass('displayed');                        
            };
          });
      }
      else {
          $('ul.menu li a.displayed').removeClass('displayed'); 
      }
  });
  
});