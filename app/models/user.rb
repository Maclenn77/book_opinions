class User < ApplicationRecord
  has_many :opinions
  has_many :followings, foreign_key: :follower_id, class_name: 'Following'
  has_many :followees, foreign_key: :followee_id, class_name: 'Following'

  before_create do
    self.token = @token
  end

  def token_generator
    temp = SecureRandom.urlsafe_base64
    temp = Digest::SHA1.hexdigest temp
    @token = temp
  end

  def following_users
    followings_array = followings.map(&followee_id)
    followings_array.compact
  end

  def total_followed_users
    followings.count
  end

  def total_followees
    followees.count
  end

  def followed?(user)
    u = user
    u.followings.find_by(followee_id: id)
  end

  # def follow(user)
  #   followings.create(followee_id: user.id)
  # end

  def followed
    follows = followings
    users = [id]
    follows.each do |f|
      users << f.followee_id
    end
    users
  end

  def who_to_follow
    User.where.not(id: followed)
  end

end
