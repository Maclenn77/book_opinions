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
    let(:user) { users(:juan)}

    it 'returns the total followed users' do
      expect(user.total_followed_users).to eq(2)
    end

    it 'returns the total of opinions created' do
      expect(user.total_opinions).to eq(3)
    end

    it 'returns the total of followees of an user' do
      expect(user.total_followees).to eq(2)
    end

    it 'returns following' do
      @user = users(:juan)
      @following = users(:yearin)
      expect(@user.followed?(@following)).to eq(true)
    end

    it 'returns nil if not following user' do
      @user = users(:juan)
      @following = users(:pedro)
      expect(@user.followed?(@following)).not_to eq(true)
    end

    it 'returns an array with followed users' do
      @user = users(:juan)
      @followed_one = users(:ana)
      @followed_two = users(:yearin)
      followed = @user.followed
      expect([@followed_one, @followed_two, @user]).to eq(followed)
    end

    it 'returns last user not followed by current_user' do
      @to_follow = users(:jose)
      expect(user.who_to_follow).to include(@to_follow)
    end

    it 'doesn\'t returns a user followed by current_user' do
      @current_user = users(:juan)
      @to_follow = users(:ana)
      expect(@current_user.who_to_follow).not_to include(@to_follow)
    end

    it 'returns an array with following users' do
      @current_user = users(:juan)
      @following = users(:yearin)
      expect([@following]).to include(@current_user.following)
    end

    it 'doesn\'t includes an user if it\'s not following' do
      @current_user = users(:juan)
      @not_following = users(:pedro)
      expect(@current_user.following).to include(@not_following)
    end
  end
end