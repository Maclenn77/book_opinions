require 'test_helper'

class LoginFlowTest < ActionDispatch::IntegrationTest
  include SessionsHelper

  setup do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
  end

  self.use_instantiated_fixtures = true

  test 'not login' do
    visit root_path

    while page.has_content?('Share your book opinions')
      click_link('Log out')
      sleep(3)
    end

    assert(page.has_content?('Welcome to Daiuk'))
    assert_not(page.has_content?('Share your book opinions'))
  end

  test 'login, go index page and log out' do
    user = users(:juan)
    opinion = opinions(:yearin_opinion_one)

    visit(root_path)

    click_link('Log in')

    sleep(3)

    assert(page.has_content?('Log in'))

    fill_in('session_name', with: user.name)

    click_button('Log in')

    sleep(3)

    assert(page.has_content?('Welcome,juan'))
    assert(page.has_content?(opinion.body))

    accept_confirm {click_link('Log out')}

    sleep(3)

    assert_not(page.has_content?(opinion.body))
  end
end
