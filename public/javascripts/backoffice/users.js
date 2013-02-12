$(function(){
  $(".chzn-select.long").chosen({widths: {user_organization_id_chzn: 419}});
  $(".chzn-select.short").chosen({widths: {user_organization_id_chzn: 300}});
  $('.check').click(function(e){
    e.preventDefault();
    var link = $(this);
    link.toggleClass('selected');
    link.next('input')[0].disabled = !link.hasClass('selected');
  })
});
