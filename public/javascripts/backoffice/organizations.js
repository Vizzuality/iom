$(function(){
  $('.sync_projects').submit(chooseProjectsFile);
  $('#organization_projects_file').change(importProjectsFile);
})

var chooseProjectsFile = function() {
  $('#organization_projects_file').click();
  return false;
};

var importProjectsFile = function(){
  alert('WADUS');
};
