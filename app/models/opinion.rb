class Opinion < ApplicationRecord
  belongs_to :user

  def modify_title
    t = title
    t.gsub!(/[^0-9a-zA-Z\s]/, '')
    t.gsub!(/\s/, '+')
    t
  end
end
