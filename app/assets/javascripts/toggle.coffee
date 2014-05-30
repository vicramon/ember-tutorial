$( ->

  $('.switch input').on 'click', ->
    language = $(@).attr('value')
    document.cookie = "language=" + language

  $(document).ready ->
    if document.cookie.indexOf("javascript") != -1
      $('.coffeescript').hide()
      $('.switch #javascript').prop 'checked', true
    else
      $('.javascript').hide()
      $('.switch #coffeescript').prop 'checked', true

)
