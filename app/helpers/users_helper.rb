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

  def opinion(user, opinion)
    link_to(user.fullname, user_path(user), class: 'font-weight-bold') + " said about " + link_to(opinion.title, worldcat_link(opinion), class:"font-italic")
  end

  def avatar(user)
    if user.avatar.attached?
      image_tag user.avatar.variant(combine_options: {resize: '60x60^', extent: '60x60', gravity: 'Center'} ), class: 'avatar m-2 rounded float-left'
    else
      image_tag('avatar.png', alt: user.name, width: 60, height: 60, class: 'avatar m-2 rounded float-left')
    end
  end

  def circle_avatar(user)
    if user.avatar.attached?
      image_tag user.avatar.variant(combine_options: {resize: '60x60^', extent: '60x60', gravity: 'Center'} ), class: 'avatar m-2 rounded-circle float-left'
    else
      image_tag('avatar.png', alt: user.name, width: 60, height: 60, class: 'avatar m-2 rounded-circle float-left')
    end
  end

end
