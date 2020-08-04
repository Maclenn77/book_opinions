module ApplicationHelper
  def follow(user, current_user)

    following = user.followed?(current_user)

    if following
      link_to('Unfollow', following_path(id: following.id), method: :delete)
    else
      link_to('Follow', followings_path(user_id: current_user.id,
                                        followee_id: user.id), method: :post)
    end
  end
end
