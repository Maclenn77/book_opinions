require 'test_helper'

class FollowFlowTest < ActionDispatch::IntegrationTest
  self.use_instantiated_fixtures = true

  teardown do
    Capybara.reset_sessions!
  end

  setup do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
  end

  test 'follow and unfollow an user' do
    user = users(:juan)
    to_follow_one = users(:pedro)
    to_follow_two = users(:jose)

    visit login_path

    fill_in('session_name', with: user.name)

    click_button('Log in')

    sleep(3)

    assert page.has_content?(to_follow_one.fullname)
    assert page.has_content?(to_follow_two.fullname)

    click_link('add_circle_outline', match: :first)

    sleep(3)

    assert page.has_content?('You followed')

    click_link('Pedro Donda')

    sleep(3)

    assert page.has_content?('I am  getting more followers now')

    assert page.has_content?('FOLLOWED BY')

    click_link('add_circle')

    assert page.has_content?('You Unfollow this user.')
    click_link('Log out')
  end
end
