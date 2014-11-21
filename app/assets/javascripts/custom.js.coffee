ready = ->
  $(".slidingDiv").hide()
  $(".show_hide").show()
  $(".show_hide").click ->
    $(".slidingDiv").slideToggle()
    return

$(document).ready(ready)
$(document).on('page:load', ready)
