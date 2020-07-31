module ApplicationHelper
  def follow_user(user)
    following = Following.find_by(follower_id: current_user.id, followee_id: user.id)
    if following
      link_to('Unfollow', user_following_path(following), method: :delete)
    else
      link_to('Follow', user_followings_path(user_id: current_user.id, followee_id: user.id), method: :post)
    end
  end
end
