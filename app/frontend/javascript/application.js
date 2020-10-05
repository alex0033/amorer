import Cropper from 'cropperjs'
console.log("come javascript/application.js");

$(document).on('turbolinks:load', function() {
  let cropper;

  $('#user_image').on('change', function (e) {
    const reader = new FileReader();
    reader.onload = function (e) {
      $('#preview').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });

  $('#preview').on('load', function() {
    if (typeof cropper !== 'undefined') {
      console.log(cropper);
      cropper.destroy();
    }
    $('#default_preview').hide();
    let image = document.getElementById('preview');
    cropper = new Cropper(image, {
      aspectRatio: 1 / 1,
      crop(event) {
        $('#user_x').val(event.detail.x);
        $('#user_y').val(event.detail.y);
        $('#user_width').val(event.detail.width);
        $('#user_height').val(event.detail.height);
      },
    });
  });
});
