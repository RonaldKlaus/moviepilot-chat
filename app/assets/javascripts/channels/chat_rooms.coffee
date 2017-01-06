# basicly as subscription of a consumber (subscriber) on a chanel
$ ->
  App.chat_rooms = App.cable.subscriptions.create {
      channel: "ChatRoomsChannel"
      chat_room_channel_id: $('.js--messages').data('chat-room-id')
    },

    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # we receive the message and cause we are sending plain html we can
      # append it like this
      $('.js--messages').append data['message']

    # main method, has to have the same name as the server method
    # it takes the message from the chat and pass it (the whole HTML) to server
    # site
    send_message: (message, chat_room_id) ->
      @perform 'send_message', message: message, chat_room_id: chat_room_id

    $('.js--submit').click (e) ->
      $messageBody = $('.js--message-body')
      message = $messageBody.html()
      chatRoomId = $('.js--chat-room').data("id")

      if $.trim(message).length > 1
        App.chat_rooms.send_message(message, chatRoomId)
        $messageBody.html('')
      e.preventDefault()
      return false
