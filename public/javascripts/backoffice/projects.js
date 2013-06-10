function createUploader() {
  var uploader = new qq.FineUploader({
    element: document.getElementById('uploader'),
      request: {
        endpoint: endpoint
      },
      text: {
        uploadButton: 'Import projects'
      },
      multiple: false,
      callbacks: {
        onSubmit: function(){
          restartModalWindow().fadeIn();
        },
        onComplete: function(id, fileName, response) {
          var modal_window = $('div#modal_window');

          modal_window.fadeOut(function(){
            modal_window.find('.alert').addClass('importer');
            modal_window.find('h4').html(response.title);
            modal_window.find('ul').empty();
            modal_window.find('a.button').removeClass('remove').addClass('ok').show();

            for (var i=0; i < response.errors.length; i++) {
              modal_window.find('ul').append($('<li>').text(response.errors[i]));
            };

            if (!modal_window.find('a.cancel').hasClass('ok')) {
              modal_window.find('a.cancel').addClass('ok');
            };

            if (response.success){
              modal_window.find('.alert').addClass('ok');
              modal_window.find('h4').text('Great!');
              modal_window.find('p').text(response.projects_updated_count + ' projects updated successfully :-)');
              modal_window.find('a.button').show().attr('href', '#').unbind('click').click(function(){
                modal_window.fadeOut();
              });
            } else {
              modal_window.find('a.ok').attr('href', '/admin/projects_synchronizations/' + response.id);
              if (response.projects_updated_count == 0) {
                modal_window.find('a.ok').click(cancel);
              } else {
                modal_window.find('a.cancel').removeClass('ok').click(cancel);
                modal_window.find('a.ok').click(processFileWithErrors);
              }
              modal_window.find('.alert').addClass('error');
              if (!modal_window.find('a.ok').hasClass('error')){
                modal_window.find('a.ok').addClass('error');
                modal_window.find('p').empty();
                modal_window.find('p').append($('<div/>').text(response.projects_not_updated_count + " rows with errors won't be updated."));
                if (response.projects_updated_count > 0) {
                  modal_window.find('p').append($('<div/>').text(response.projects_updated_count + " rows without errors will be updated."));
                }
              }
            }

            modal_window.find('a.cancel').css('display','inline');
            modal_window.fadeIn(function(){
              modal_window.find('ul').data('jsp', null);
              modal_window.find('ul').jScrollPane({});
            });
          });

        }
      }
  });
}

window.onload = createUploader;

function restartModalWindow() {
  var modal_window = $('div#modal_window');

  modal_window.find('.alert').removeClass('ok').removeClass('error');
  modal_window.find('a.ok').removeClass('error');
  modal_window.find('a.cancel').hide();
  modal_window.find('a.button').hide();

  modal_window.find('h4').html('Processing file...');
  modal_window.find('p').html('Please wait.');
  modal_window.find('ul').empty();
  return modal_window;
};

function processFileWithErrors(evt){
  evt.preventDefault();

  var modal_window = $('div#modal_window');
  var link = $(this);

  $.ajax({
    url: $(this).attr('href'),
    type: 'PUT',
    dataType: 'json',
    complete: function(result) {
      synchronization_json = JSON.parse(result.response);
      modal_window.find('.alert').addClass('ok');
      modal_window.find('h4').text('Great!');
      modal_window.find('p').text(synchronization_json.projects_updated_count + ' projects updated successfully :-)');
      modal_window.find('a.button').show();
      link.attr('href', '#').unbind('click').click(function(){
        modal_window.fadeOut();
      });
    }
  });
  modal_window.fadeOut(function(){
    restartModalWindow().fadeIn();
  });
};

function cancel(evt){
  evt.preventDefault();
  $('div#modal_window a.cancel').click();
};
