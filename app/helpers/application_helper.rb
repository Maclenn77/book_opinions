module ApplicationHelper
  def follow(user, current_user)
    return nil unless user != current_user

    following = user.followed?(current_user)

    if following
      link_to('add_circle', following_path(id: following.id),
              class: 'text-secondary h2', method: :delete)
    else
      link_to('add_circle_outline',
              followings_path(user_id: current_user.id, followee_id: user.id),
              class: 'text-secondary h2', method: :post)
    end
  end
end
