class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def authenticate!
    Rails.logger.debug "ApplicationController#authenticate!"
    redirect_to root_path if current_user.blank?
  end

  def current_user
    Rails.logger.debug "ApplicationController#authenticate! #{cookies.signed["user_id"]}"
    @current_user ||= User.find_by(id: cookies.signed["user_id"])
  end
end
