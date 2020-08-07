class Opinion < ApplicationRecord
  belongs_to :user

  scope :user_opinions, ->(user) { where(user_id: user) }

  def modify_title
    t = title.dup
    t.gsub!(/[^0-9a-zA-Z\s]/, '')
    t.gsub!(/\s/, '+')
    t
  end
end
