jQuery(function($) {
  $(".prettyprint").text(JSON.stringify(JSON.parse($(".prettyprint").data("response")), null, 2))
})
