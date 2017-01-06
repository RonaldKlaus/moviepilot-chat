# We need this job to handle the message and send it back to the clients
class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast(
      "chat_rooms_#{message.chat_room.id}_channel",
      message: render_message(message)
    )
  end

  private

  def render_message(message)
    Rails.logger.debug "message: #{message}"
    # New in Rails 5 you can call render like this
    # We just want to render the partial as HTML, it is also posible to handle JSON
    MessagesController.render('messages/message', message: message)
  end
end
