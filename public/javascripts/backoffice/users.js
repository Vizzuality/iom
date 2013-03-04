$(function(){
  $(".chzn-select.long").chosen({widths: {user_organization_id_chzn: 419}});
  $(".chzn-select.short").chosen({widths: {user_organization_id_chzn: 300}});
  $('.check').click(function(e){
    e.preventDefault();
    var link = $(this);
    link.toggleClass('selected');
    link.next('input')[0].disabled = !link.hasClass('selected');
  })
  $('#users_list_filter select').change(function(evt){
    $(this).closest('form').submit();
  });
  //$('#users_list_filter').submit(function(evt){
    //evt.preventDefault();
    //var form = $(this);
    //$.get(form.attr('action'), form.serialize(), function(html){
      //$('.users_list').html(html);
    //})
  //});
});
