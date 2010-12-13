$(document).ready( function() {
    
    // CUSTOM SCROLLBARS
    if ($('.scroll_pane').length > 0){
    
        // OTHER ATTEMP
        $('.scroll_pane').jScrollPane({
                           autoReinitialise:false });
    }    

  // MENU CLICKS
  $('ul.menu li a.main_option').click(function(ev){
      ev.stopPropagation();
      ev.preventDefault();
      
      if (($(this).children('span.with_suboptions').length > 0)&&(!$(this).hasClass('displayed'))){
                             
          // Close all tabs
          $('ul.menu li a.displayed').removeClass('displayed');          
          $('ul.menu li.clicked').removeClass('clicked');
          
          $(this).addClass('displayed');
          $(this).parent().addClass('clicked');
          
          // If there are some scroll
          if ($(this).parent().find('.scroll_pane').length > 0){
            resetCombo($(this).parent());  
          }
          
          $(document).click(function(event) {
                if ((!$(event.target).closest('ul.suboptions li a').length)&&(!$(event.target).closest('ul.scroll_pane').length)&&(!$(event.target).closest('input#ngos_search').length)) {
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

function resetCombo(elementToUpdate){
    var element = elementToUpdate.find('.scroll_pane');
    var api = element.data('jsp');
    api.reinitialise();
}
