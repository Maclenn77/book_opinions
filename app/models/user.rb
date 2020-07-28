class User < ApplicationRecord
  has_many :opinions
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Following'
  has_many :followees, through: :followed_users
end
