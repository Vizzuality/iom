$(document).ready( function() {

  $('p.paylock a').click(function(ev){
    ev.stopPropagation();
    ev.preventDefault();
    if ($(this).parent().hasClass("close")) {
      $(this).parent().removeClass("close");
      $(this).parent().addClass("open");
      $(this).text('Click to close the specific fields');
      $(this).parent().parent().parent().parent().removeClass('closed');
      $(this).parent().parent().parent().parent().addClass('enabled');
      $(this).parent().parent().parent().find('input').removeAttr('disabled');
      $(this).parent().parent().parent().find('textarea').removeAttr('disabled');
    } else {
      $(this).parent().removeClass("open");
      $(this).parent().addClass("close");
      $(this).text('Click to edit the specific fields');
      $(this).parent().parent().parent().parent().addClass('closed');
      $(this).parent().parent().parent().parent().removeClass('enabled');
      $(this).parent().parent().parent().find('input').attr('disabled','true');
      $(this).parent().parent().parent().find('textarea').attr('disabled','true');
    }
  });

  floatingSubmit($('form .submit'), $('div.main_layout div.block div.med div.right div.export_import'))
});
