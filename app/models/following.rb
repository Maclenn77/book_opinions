# frozen_string_literal: true

class Following < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  validate :not_same_user
  validate :not_following

  def not_same_user
    if follower_id == followee_id
      errors.add(:followee_id, 'Follower and followee can\'t be the same')
    end
  end

  def not_following
    following = Following.find_by(follower: follower_id, followee: followee_id)
    unless following.nil?
      errors.add(:followee_id, 'You\'re already following this user')
    end
  end
end
