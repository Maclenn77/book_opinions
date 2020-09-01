# This Following class is a join table between users that follow and followed
class Following < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  validate :not_same_user
  validate :not_following

  def not_same_user
    errors.add(:followee_id, 'Follower and followee can\'t be the same') if follower_id == followee_id
  end

  def not_following
    following = Following.find_by(follower: follower_id, followee: followee_id)
    errors.add(:followee_id, 'You\'re already following this user') unless following.nil?
  end
end
