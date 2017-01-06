# basicly as subscription of a consumber (subscriber) on a chanel
$ ->
  App.chat_rooms = App.cable.subscriptions.create {
      channel: "ChatRoomsChannel"
      chat_room_id: $(".js--chat-room").data("id")
    },

    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    # we receive the message and cause we are sending plain html we can
    # append it like this
    received: (data) ->
      message = data["message"]

      switch data["method"]
        when "create" then $('.js--messages').append(message)
        when "update" then $(".js--message[data-id=#{message}]").replaceWith(message)
        when "destroy" then $(".js--message[data-id=#{message}]").remove()

    # main method, has to have the same name as the server method
    # it takes the message from the chat and pass it (the whole HTML) to server
    # site
    send_message: (message, chat_room_id) ->
      @perform 'send_message', message: message, chat_room_id: chat_room_id
