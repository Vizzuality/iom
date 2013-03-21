function createUploader() {
  var uploader = new qq.FineUploader({
    element: document.getElementById('uploader'),
      request: {
        endpoint: endpoint
      },
      multiple: false,
      callbacks: {
        onSubmit: function(){
          var modal_window = $('div#modal_window');
          modal_window.find('h4').html('Processing file...');
          modal_window.find('p').html('Please wait.');
          modal_window.find('ul').empty();
          modal_window.fadeIn();
        },
        onComplete: function(id, fileName, response) {
          var modal_window = $('div#modal_window');

          modal_window.fadeOut(function(){
            modal_window.find('.alert').addClass('importer');
            modal_window.find('h4').html(response.title);
            modal_window.find('ul').empty();

            for (var i=0; i < response.errors.length; i++) {
              modal_window.find('ul').append($('<li>').text(response.errors[i]));
            };

            if (!modal_window.find('a.cancel').hasClass('ok')) {
              modal_window.find('a.cancel').addClass('ok');
            };

            if (response.success){
              $('div.alert').addClass('ok');
              $('div#modal_window h4').text('Great!');
              $('div#modal_window p').text(' projects updated successfully :-)');
            } else {
              $('div.alert').addClass('error');
              modal_window.find('ul').jScrollPane({autoReinitialise: false});
              if (!modal_window.find('a.ok').hasClass('error')){
                modal_window.find('a.ok').addClass('error');
                modal_window.find('p').text('This data will not be registered in the database.');
              }
            }

            modal_window.find('a.cancel').css('display','inline');
            modal_window.fadeIn();
          });

        }
      }
  });
}

window.onload = createUploader;
