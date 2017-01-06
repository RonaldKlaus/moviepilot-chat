$ ->
  $('.js--submit').click (event) ->
    $messageBody = $('.js--message-body')
    message = $messageBody.html()

    if $.trim(message).length > 1
      App.chat_rooms.send_message(message, $('.js--chat-room').data("id"))
      $messageBody.html('')

    event.preventDefault()

  $(".js--message--edit").click (event) ->
    debugger

    event.preventDefault()
