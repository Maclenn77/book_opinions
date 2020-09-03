# This is the model Opinion class
class Opinion < ApplicationRecord
  belongs_to :user

  scope :user_opinions, ->(user) { where(user_id: user) }
  scope :last_opinions, ->(user) { includes(:user).where(user: user.followees).or(includes(:user).where(user: user)).order(created_at: :desc).limit(10) }

  validates :title, presence: true, length: { in: 2..50 }
  validates :body, presence: true, length: { in: 5..2000 }

  def modify_title
    t = title.dup
    t.gsub!(/[^0-9a-zA-Z\s]/, '')
    t.gsub!(/\s/, '+')
    t
  end

  def feed(user)
    feed = Opinion.where(user: user.followees).where(user: user)
    feed.order(created_at: :desc).limit(10)
  end
end
