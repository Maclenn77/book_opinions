# frozen_string_literal: true

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

  def session_icon
    unless current_user.nil?
      return link_to('exit_to_app', signout_path, class: 'text-dark',
                                                  method: :delete, data: { confirm: 'Are you sure ?' })
    end
    link_to('power_settings_new', login_path, class: 'text-dark')
  end

  def session_nav
    unless current_user.nil?
      link_to user_profile, user_path(current_user), class: 'text-secondary'
    end
  end
end
