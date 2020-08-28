require 'test_helper'

class LoginFlowTest < ActionDispatch::IntegrationTest
  include SessionsHelper

  test 'create an new opinion' do
    user = users(:juan)

    visit login_path

    fill_in('session_name', with: user.name)

    click_button('Log in')

    sleep(3)

    assert page.has_content?('Share your book opinions')

    fill_in('opinion_title', with: 'Test for Dummies')
    fill_in('opinion_body', with: 'It\'s a dummy book')

    click_button('Post')

    sleep(3)

    assert page.has_content?('It\'s a dummy book')

    find_link('Test for Dummies').visible?

    visit root_path

    click_link('Log out')
  end
end
