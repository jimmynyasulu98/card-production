//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require main
//= require print

import "@hotwired/turbo-rails"
import "./controllers"


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

/** Ajax call from print window to mark the card printed */
window.onafterprint = function() {
  $.ajax({
    type: "POST",
    url: "mark-printed",
    data :  document.cookie,
    /** render template view in the controller action */
    success: function (res) {
      Turbo.renderStreamMessage(res)
    }
  });
};

