module UsersHelper

  def user_profile
    if current_user.nil?
      render 'sessions/form'
    else
      current_user.fullname.upcase
    end
  end

  def current_user_following
    current_user.total_followed_users unless current_user.nil?
  end

  def current_user_followees
    current_user.total_followees unless current_user.nil?
  end
end
