require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'the total followed users' do
    assert_equal(5,total_followed_users)
  end
  
end
