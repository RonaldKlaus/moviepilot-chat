# We need this job to handle the message and send it back to the clients
class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, room_id, method = "create")
    message = case method
    when "create" then rendered_message(message)
    when "destroy" then message
    end

    # broadcast to the channel, with the name in chat_rooms_channel.rb
    ActionCable.server.broadcast("chat_rooms_channel_#{room_id}", message: message, method: method)
  end

  private

  # New in Rails 5 you can call render like this
  # We just want to render the partial as HTML, it is also posible to handle JSON
  def rendered_message(message)
    ApplicationController.renderer.render(partial: "messages/message", locals: {message: message})
  end
end
