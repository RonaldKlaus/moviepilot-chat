# We need this job to handle the message and send it back to the clients
class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, method = "create")
    message = case method
    when "create", "update" then render_message(message)
    when "destroy" then message
    end

    ActionCable.server.broadcast("chat_rooms_channel", message: message, method: method)
  end

  private

  # New in Rails 5 you can call render like this
  # We just want to render the partial as HTML, it is also posible to handle JSON
  def render_message(message)
    ApplicationController.renderer.render message
  end
end
