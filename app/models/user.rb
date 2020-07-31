class User < ApplicationRecord
  has_many :opinions
  has_many :followings, foreign_key: :follower_id, class_name: 'Following'
  has_many :followees, through: :followings

  before_create do
    self.token = @token
  end

  def token_generator
    temp = SecureRandom.urlsafe_base64
    temp = Digest::SHA1.hexdigest temp
    @token = temp
  end

  def total_followed_users
    followings.count
  end

  def total_followees
    followees.count
  end

  def who_to_follow
    follow = []
    users = User.all
    users.each do |u|
      follow << u if followings.include?(u) == false && (u == self) == false
    end
    follow
  end
end
