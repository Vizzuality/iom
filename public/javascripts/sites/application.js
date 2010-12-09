$(document).ready( function() {

  // MENU CLICKS
  $('ul.menu li a').click(function(ev){
    
      ev.stopPropagation();
      ev.preventDefault();
      
      if (($(this).children('span.with_suboptions').length > 0)&&(!$(this).hasClass('displayed'))){

          // Close all tabs
          $('ul.menu li a.displayed').parent().find('ul.suboptions').css('display','none');
          $('ul.menu li a.displayed').removeClass('displayed');          
          
          $(this).parent().children('ul.suboptions').fadeIn('fast');
          $(this).addClass('displayed');
          
          $(document).click(function(event) {
            if (!$(event.target).closest('ul.menu li a').length) {
              $('ul.menu li').find('ul.suboptions').css('display','none');
              $('ul.menu li a.displayed').removeClass('displayed');                        
            };
          });
      }
      else {
          $('ul.menu li a.displayed').parent().find('ul.suboptions').css('display','none');
          $('ul.menu li a.displayed').removeClass('displayed'); 
      }
  });
  
});