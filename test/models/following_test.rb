require 'test_helper'

class FollowingTest < ActiveSupport::TestCase
  test 'don\'t follow if follower is the same than followee' do
    follower = users(:juan)
    followee = users(:juan)
    new_following = follower.followings.new(followee: followee)
    assert_equal(new_following.valid?, false)
  end
  
  test "create a valid following" do
    follower = users(:juan)
    followee = users(:pedro)
    new_following = follower.followings.new(followee: followee)
    assert_equal(new_following.valid?, true)
  end
end
