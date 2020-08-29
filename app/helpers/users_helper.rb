# frozen_string_literal: true

# This is module for Users
module UsersHelper
  def user_profile
    if current_user.nil?
      render 'sessions/form'
    else
      current_user.fullname.upcase
    end
  end

  def following_by(user)
    c = user
    c.total_followed_users unless user.nil?
  end

  def followees_of(user)
    c = user
    c.total_followees unless user.nil?
  end

  def opinions_of(user)
    c = user
    c.total_opinions unless user.nil?
  end

  def show_opinion(user, opinion)
    link_to(user.fullname, user_path(user),
            class: 'font-weight-bold') + ' said about ' +
      link_to(opinion.title, worldcat_link(opinion), class: 'font-italic')
  end

  def avatar(user)
    if user.avatar.attached?
      image_tag user.avatar.variant(combine_options: { resize: '40x40^',
                                                       extent: '40x40',
                                                       gravity: 'Center' }),
                class: 'avatar m-2 rounded float-left'
    else
      image_tag('avatar.png', alt: user.name, width: 40, height: 40,
                              class: 'avatar m-2 rounded float-left')
    end
  end

  def circle_avatar(user)
    if user.avatar.attached?
      image_tag user.avatar.variant(combine_options: { resize: '60x60^',
                                                       extent: '60x60',
                                                       gravity: 'Center' }),
                class: 'avatar m-2 rounded-circle float-left'
    else
      image_tag('avatar.png', alt: user.name, width: 60, height: 60,
                              class: 'avatar m-2 rounded-circle float-left')
    end
  end

  def book_cover(user)
    if user.cover.attachment
      image_tag user.cover.variant(combine_options: { resize: '600x256^',
                                                      extent: '600x256',
                                                      gravity: 'Center' }),
                class: 'cover'
    else
      image_tag('cover-default.jpg', alt: 'default cover', width: 600,
                                     height: 256, class: 'cover')
    end
  end

  def big_circle_avatar(user)
    if user.avatar.attached?
      image_tag user.avatar.variant(combine_options: { resize: '100x100^',
                                                       extent: '100x100',
                                                       gravity: 'Center' }),
                class: 'avatar m-2 rounded-circle float-left'
    else
      image_tag('avatar.png', alt: user.name, width: 100, height: 100,
                              class: 'avatar m-2 rounded-circle')
    end
  end
end
