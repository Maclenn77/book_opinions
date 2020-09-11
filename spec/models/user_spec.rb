require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures username presence' do
      user = User.new(name: nil, fullname: 'Juan').save
      expect(user).to eq(false)
    end

    it 'ensures username is not too short' do
      user = User.new(name: 'jo', fullname: 'Juan').save
      expect(user).to eq(false)
    end

    it 'ensures username is not too long' do
      user = User.new(name: ('jo' * 10), fullname: 'Juan').save
      expect(user).to eq(false)
    end

    it 'ensures fullname presence' do
      user = User.new(name: 'Juan', fullname: nil).save
      expect(user).to eq(false)
    end

    it 'ensures fullname is not too long' do
      user = User.new(name: 'john', fullname: ('jo' * 30)).save
      expect(user).to eq(false)
    end
  end

  context 'method tests' do
    fixtures :users, :followings, :opinions
    let(:user) { users(:juan) }

    it 'returns the total followed users' do
      expect(user.total_followed_users).to eq(2)
    end

    it 'returns the total of opinions created' do
      expect(user.total_opinions).to eq(3)
    end

    it 'returns the total of followees of an user' do
      expect(user.total_followees).to eq(1)
    end

    it 'returns following' do
      @following = users(:yearin)
      follow = followings(:three)
      expect(user.followed?(@following)).to eq(follow)
    end

    it 'returns nil if not following user' do
      @following = users(:pedro)
      expect(user.followed?(@following)).to eq(nil)
    end

    it 'returns last user not followed by current_user' do
      to_follow = users(:jose)
      expect(User.who_to_follow(user)).to include(to_follow)
    end

    it 'doesn\'t returns a user followed by current_user' do
      @to_follow = users(:ana)
      expect(User.who_to_follow(user)).not_to include(@to_follow)
    end

    it 'returns an array with following users' do
      @following = followings(:one)
      expect(user.following_users).to include(@following)
    end
  end
end
