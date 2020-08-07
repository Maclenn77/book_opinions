module UsersHelper

  def user_profile
    if current_user.nil?
      render 'sessions/form'
    else
      current_user.fullname.upcase
    end
  end

  def following_by(current_user)
    c = current_user
    c.total_followed_users unless current_user.nil?
  end

  def followees_of(current_user)
    c = current_user
    c.total_followees unless current_user.nil?
  end

  def last_followers(user)
    user.followed[0..2]
  end
end
