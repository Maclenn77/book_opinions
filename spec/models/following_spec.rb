require 'rails_helper'

RSpec.describe Following, type: :model do
  fixtures :users, :followings
  context 'validation tests' do
    it 'ensures don\'t following user if it\'s the same' do
      follower = users(:juan)
      followee = users(:juan)
      new_following = follower.followings.new(followee: followee)
      expect(new_following.valid?).to eq(false)
    end

    it 'ensures don\'t following yet an user' do
      follower = users(:juan)
      followee = users(:yearin)
      new_following = follower.followings.new(followee: followee)
      expect(new_following.valid?).to eq(false)
    end
  end

  context 'scope test' do
    it 'return followings where user is a followee' do
      user = users(:juan)
      follows = Following.followers(user)
      expect(follows).to include(followings(:three))
    end

    it 'doesn\'t return followings where user is not a followee' do
      user = users(:juan)
      follows = Following.followers(user)
      expect(follows).to_not include(followings(:one))
    end
  end
end
