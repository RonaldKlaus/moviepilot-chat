# basicly as subscription of a consumber (subscriber) on a chanel
$ ->
  if $(".js--new-message").length
    # App.chat_rooms = App.cable.subscriptions.create "ChatRoomsChannel",
    # This is the params hash in the ChatRoomsChannel#subscribed method
    App.chat_rooms = App.cable.subscriptions.create {
        channel: "ChatRoomsChannel" #this has to be the right class name!!
        chat_room_id: $(".js--chat-room").data("id")
      },

      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      # we receive the message and cause we are sending plain html
      # we can append it like this:
      received: (data) ->
        message = data["message"]

        switch data["method"]
          when "create"
            $messages = $('.js--messages')
            if $messages.children().length
              $messages.children().first().before(message)
            else
              $messages.append(message)
          when "destroy" then $(".js--message[data-id=#{message}]").remove()

      # main method, has to have the same name as the server method
      # it takes the message from the chat and pass it (the whole HTML) to server
      # site
      send_message: (message, chat_room_id) ->
        @perform 'send_message', message: message, chat_room_id: chat_room_id
