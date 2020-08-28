require 'test_helper'

class LoginFlowTest < ActionDispatch::IntegrationTest
  include SessionsHelper

  test 'not login' do
    visit root_path

    assert(page.has_content?('Welcome to Daiuk'))
    assert_not page.has_content?('Share your book opinions')

  end

  test 'login, go index page and log out' do
    user = users(:juan)
    opinion = opinions(:yearin_opinion_one)

    visit root_path

    click_link('Log in')

    sleep(3)

    assert page.has_content?('Log in')

    fill_in('session_name', with: user.name)

    click_button('Log in')

    sleep(3)

    assert page.has_content?('Welcome,juan')
    assert page.has_content?(opinion.body)

    click_link('Log out')

    assert_not page.has_content?(opinion.body)
  end
end
