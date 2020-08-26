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

  test 'returns an array with followed users' do
    @user = users(:juan)
    @followed_one = users(:ana)
    @followed_two = users(:yearin)
    followed = @user.followed
    assert_equal([@followed_one, @followed_two, @user], followed)
  end

  test 'returns last user not followed by current_user' do
    @current_user = users(:juan)
    @to_follow = users(:jose)
    assert_includes(@current_user.who_to_follow, @to_follow)
  end

  test 'doesn\'t returns a user followed by current_user' do
    @current_user = users(:juan)
    @to_follow = users(:ana)
    refute_includes(@current_user.who_to_follow, @to_follow)
  end

  test 'returns an array with following users' do
    @current_user = users(:juan)
    @following = users(:yearin)
    assert_equal([@following], @current_user.following)
  end

  test 'doesn\'t includes an user if it\'s not following' do
      @current_user = users(:juan)
      @not_following = users(:pedro)
      refute_includes(@current_user.following, @not_following)
  end

  test 'invalid user if there\'s not a name' do
    @new_user = User.create(name: nil, fullname: 'Juan')
    assert_equal(@new_user.valid?, false)
  end

  test 'invalid user if name is too short' do
    @new_user = User.create(name: 'jo', fullname: 'Juan')
    assert_equal(@new_user.valid?, false)
  end

  test 'invalid user if name is too long' do
    @new_user = User.create(name: ('jo' * 10), fullname: 'Juan')
    assert_equal(@new_user.valid?, false)
  end

  test 'invalid user if there\'s not a fullname' do
    @new_user = User.create(name: ('john'), fullname: nil)
    assert_equal(@new_user.valid?, false)
  end

  test 'invalid user if fullname is too short' do
    @new_user = User.create(name: 'john', fullname: 'jo')
    assert_equal(@new_user.valid?, false)
  end

  test 'invalid user if fullname is too long' do
    @new_user = User.create(name: 'john', fullname: ('jo' * 30))
    assert_equal(@new_user.valid?, false)
  end

  test 'create a new user' do
    @new_user = User.create(name: 'john', fullname: 'John Lennon')
    assert_equal(@new_user.valid?, true)
  end
end
