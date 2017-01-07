$ ->
  $('.js--submit').click (event) ->
    $messageBody = $('.js--message-body')
    message = $messageBody.val()

    if $.trim(message).length > 1
      App.chat_rooms.send_message(message, $('.js--chat-room').data("id"))
      $messageBody.val('')

    event.preventDefault()

  $(".js--message--edit").click (event) ->
    alert("Not implemented yet")
    event.preventDefault()
