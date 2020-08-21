require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'returns the total followed users' do
    @user = users(:juan)
    assert_equal(2, @user.total_followed_users)
  end

  test 'returns the total of opinions created' do
    @user = users(:juan)
    assert_equal(3, @user.total_opinions)
  end

  test 'returns the total of followees of an user' do
    @user = users(:juan)
    assert_equal(1, @user.total_followees)
  end

  test 'returns following' do
    @user = users(:juan)
    @following = users(:yearin)
    assert @user.followed?(@following)
  end

  test 'returns nil if not following user' do
    @user = users(:juan)
    @following = users(:pedro)
    assert_not @user.followed?(@following)
  end

  test 'returns id of followed users' do
    @user = users(:juan)
    @followed_one = users(:ana)
    @followed_two = users(:yearin)
    followed = @user.followed
    assert_equal([@user, @followed_one, @followed_two], followed)
  end
end
