import Cropper from 'cropperjs'

$(document).on('turbolinks:load', function() {
  $('#user_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#preview').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });

  $('#preview').on('load', function() {
    let image = document.getElementById('preview');
    let cropper = new Cropper(image, {
      aspectRatio: 1 / 1,
      crop(event) {
        console.log(event.detail.x);
        console.log(event.detail.y);
        console.log(event.detail.width);
        console.log(event.detail.height);
        console.log(event.detail.rotate);
        console.log(event.detail.scaleX);
        console.log(event.detail.scaleY);
      },
    });
  });
});
