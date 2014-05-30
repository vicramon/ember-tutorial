$( ->

  $('.switch input').on 'click', ->
    language = $(@).attr('value')
    document.cookie = "language=" + language
    toggleLanguage(language)

  $(document).ready ->
    language = if document.cookie.indexOf("javascript") != -1
      "javascript"
    else
      "coffeescript"
    toggleLanguage(language)

  toggleLanguage = (language) ->
    if language is "javascript"
      $('.coffeescript').hide()
      $('.javascript').show()
      $('.switch #javascript').prop 'checked', true
    else
      $('.javascript').hide()
      $('.coffeescript').show()
      $('.switch #coffeescript').prop 'checked', true

)
