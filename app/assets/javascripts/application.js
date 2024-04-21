//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require main
//= require print


$(document).on('change', 'input[type="file"]' ,function(event) {
    var obj_custom = this;
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      img.src = file.target.result;
      img.width=84;
      $(obj_custom).siblings('.target').html(img);
    }
    reader.readAsDataURL(image);
  });
