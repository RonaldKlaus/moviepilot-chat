class MessagesController < ApplicationController
  load_resource

  def update
    @message.update_attributes(message_params)
  end

  def destroy
    @message.destroy
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
