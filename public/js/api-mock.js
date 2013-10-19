jQuery(function($) {
  $(".prettyprint").text(JSON.stringify(JSON.parse($(".prettyprint").text().trim() || "{}"), null, 2));

  $('#show-params').click(function() {
    $('#create-api .params').show();
  })

  $('#show-status').click(function() {
    $('#create-api .status').show();
  })

  $('#add-params').click(function() {
    $('#create-api .params-value').append("<div class='col-lg-4'>" + 
          "<input type='text' placeholder='NAME' class='form-control' name='route[params_key][]'>" +
          "</div><div class='col-lg-7'><input type='text' placeholder='VALUE' " + 
          "class='form-control' name='route[params_value][]'></div>");
  })

})
