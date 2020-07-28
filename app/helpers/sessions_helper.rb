module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.update(token: @token)
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:token] = user.token
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    cookies.delete(:token)
    @current_user = nil
  end
end
