module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      logger.add_tags 'ActionCable', current_user.email
    end

    protected

    def current_user # this checks whether a user is authenticated with devise
      @current_user ||= (current_user = env['warden'].user) ? current_user : User.first
    end
  end
end
