require 'rails_helper'

RSpec.describe 'testing login flow', type: :feature do
  include SessionsHelper
  fixtures :users, :opinions, :followings
  let(:user) { users(:juan) }
  let(:opinion) { opinions(:yearin_opinion_one) }

  teardown do
    Capybara.reset_sessions!
  end

  setup do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
  end

  scenario 'not login' do
    visit root_path

    expect(page).to have_content('Welcome to Daiuk')
    expect(page).to_not have_content('Share your book opinions')
  end

  scenario 'login and log out' do
    visit(root_path)

    click_link('Log in')

    sleep(3)

    expect(page).to have_content('Log in')

    fill_in('session_name', with: user.name)

    click_button('Log in')

    sleep(3)

    expect(page).to have_content(/(Welcome,juan)/)
    expect(page).to have_content(opinion.body)

    accept_confirm { click_link('Log out') }

    sleep(3)

    expect(page).to_not have_content(opinion.body)
  end
end
