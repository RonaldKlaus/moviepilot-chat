# This is the class for the connection to the cable server.
# Every WebSocket needs it. The main function is basicly for the authorization.
# For example getting a user, check, if she or he is allowed to connect.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      # to specify special log tags
      logger.add_tags 'ActionCable', self.current_user.try(:name)
      Rails.logger.debug ">>> Connection#connect"
    end

    def disconnect
      Rails.logger.debug ">>> Connection#disconnect"
      # Cleanup the user disconnected
    end

    protected

    def current_user
      return unless cookies.signed[:user_id]
      # we can use cookies, cause the websocket connection is established with
      # the cookies from the domain being sent along
      current_user = User.find(cookies.signed[:user_id])
      current_user || reject_unauthorized_connection
    end
  end
end
