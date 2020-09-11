require 'rails_helper'

RSpec.describe 'followings', type: :feature do
  fixtures :users, :opinions, :followings
  let(:user) { users(:juan) }
  let(:to_follow_one) { users(:pedro) }
  let(:to_follow_two) { users(:jose) }

  teardown do
    Capybara.reset_sessions!
  end

  setup do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
  end

  scenario 'follow and unfollow an user ' do
    visit login_path

    fill_in('session_name', with: user.name)

    click_button('Log in')

    sleep(3)

    expect(page).to have_content(to_follow_one.fullname)
    expect(page).to have_content(to_follow_two.fullname)

    click_link('add_circle_outline', match: :first)

    sleep(3)

    expect(page).to have_content('You followed')

    click_link('Pedro Donda')

    sleep(3)

    expect(page).to have_content('getting more followers now')

    expect(page).to have_content('FOLLOWED BY')

    click_link('add_circle')

    expect(page).to have_content('You Unfollow this user.')
    click_link('Log out')
  end
end
