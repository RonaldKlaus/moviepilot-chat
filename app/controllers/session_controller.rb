class SessionController < ApplicationController
  def create
    user = User.authenticate(session_params[:username], session_params[:password])

    if user.present?
      @status = 200
      cookies.signed[:user_id] = user.id
    end

    redirect_to root_path
  end

  def destroy
    reset_session
    cookies.signed[:user_id] = nil
    redirect_to root_path
  end

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
