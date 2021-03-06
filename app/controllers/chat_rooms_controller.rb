class ChatRoomsController < ApplicationController
  before_action :authenticate!
  
  def index
    @chat_rooms = ChatRoom.all
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find(params[:id])
    @message = Message.new
  end
end
