class Opinion < ApplicationRecord
  belongs_to :user

  scope :user_opinions, ->(user) { where(user_id: user) }
  scope :last_opinions, ->(user) { includes(:user).where(user_id: user.followed).order(created_at: :desc).limit(10) }

  def modify_title
    t = title.dup
    t.gsub!(/[^0-9a-zA-Z\s]/, '')
    t.gsub!(/\s/, '+')
    t
  end
end
