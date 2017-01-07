# This is the Stream
class ChatRoomsChannel < ApplicationCable::Channel
  # Method to start streaming from a channel
  # We can many channels at the same time
  # (identifiend by something like "channel_room_#{params[:room_id]}"
  # By default there is only one channel
  def subscribed
    # the channel can also be a an object, like User or Comment
    # use params[:chat_room_id] to separat channels
    stream_from "chat_rooms_channel_#{params[:chat_room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # this method has to have the same name as in room.js.coffee
  # it fires the send_message from chat_rooms.coffee
  def send_message(data)
    current_user.messages.create!(body: data["message"], chat_room_id: data["chat_room_id"])
    # the next line broadcasts the message without a job. BUT: that is only the message.
    # We want do more :)
    # ActionCable.server.broadcast("chat_rooms_channel", message: data["message"])
  end
end
