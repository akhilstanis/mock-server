jQuery(function($) {
  $(".prettyprint").text(JSON.stringify(JSON.parse($(".prettyprint").text()), null, 2))
})
