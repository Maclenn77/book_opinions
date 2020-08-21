class User < ApplicationRecord
  has_many :opinions
  has_many :followings, foreign_key: :follower_id, class_name: 'Following'
  has_many :followees, foreign_key: :followee_id, class_name: 'Following'
  has_one_attached :avatar
  has_one_attached :cover

  scope :last_users, -> { all.limit(3).order('created_at DESC')}

  before_create do
    self.token = @token
  end

  def token_generator
    temp = SecureRandom.urlsafe_base64
    temp = Digest::SHA1.hexdigest temp
    @token = temp
  end

  def following_users
    followings.includes(:followee)
  end

  def total_followed_users
    followings.count
  end

  def total_followees
    followees.count
  end

  def total_opinions
    opinions.count
  end

  def followed?(user)
    u = user
    u.followings.find_by(followee_id: id) unless u.nil?
  end

  def followed
    follows = followings
    users = []
    follows.each do |f|
      users << f.followee
    end
    users << self
  end

  def who_to_follow
    User.where.not(id: followed)
  end

  def last_followers
    followees.limit(3)
  end
end
