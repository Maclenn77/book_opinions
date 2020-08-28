# frozen_string_literal: true

require 'test_helper'

class OpinionTest < ActiveSupport::TestCase
  test 'scope of user opinions include the opinion of a user' do
    @user = users(:juan)
    @opinion = opinions(:juan_opinion_one)
    assert_includes(Opinion.user_opinions(@user), @opinion)
  end

  test 'scope of user opinions doesn\'t include opinion of other user' do
    @user = users(:juan)
    @opinion = opinions(:yearin_opinion_one)
    refute_includes(Opinion.user_opinions(@user), @opinion)
  end

  test 'last opinions includes opinions of user followed by current user' do
    @current_user = users(:juan)
    @opinion = opinions(:yearin_opinion_one)
    assert_includes(Opinion.last_opinions(@current_user), @opinion)
  end

  test 'last opinions doesn\'t include opinions of not followed user' do
    @current_user = users(:ana)
    @opinion = opinions(:juan_opinion_one)
    refute_includes(Opinion.last_opinions(@current_user), @opinion)
  end

  test 'last opinions are in desc order' do
    @current_user = users(:juan)
    @opinion = opinions(:yearin_opinion_three)
    assert_equal(Opinion.last_opinions(@current_user)[0], @opinion)
  end

  test 'opinions should have a title' do
    user = users(:juan)
    @new_opinion = user.opinions.create(title: nil, body: 'Good untitled book')
    assert_equal(@new_opinion.valid?, false)
  end

  test 'opinion title should have more than one character' do
    user = users(:juan)
    @new_opinion = user.opinions.create(title: 'I', body: 'Good short titled book')
    assert_equal(@new_opinion.valid?, false)
  end

  test 'opinion title should have less than 50 characters' do
    user = users(:juan)
    @new_opinion = user.opinions.create(title: ('I' * 51), body: 'Good long titled book')
    assert_equal(@new_opinion.valid?, false)
  end

  test 'opinion should have a body' do
    user = users(:juan)
    @new_opinion = user.opinions.create(title: 'Me, robot', body: nil)
    assert_equal(@new_opinion.valid?, false)
  end

  test 'opinion should have more than 5 characters' do
    user = users(:juan)
    @new_opinion = user.opinions.create(title: 'Me, robot', body: 'nil')
    assert_equal(@new_opinion.valid?, false)
  end

  test 'opinion should have less than 2000 characters' do
    user = users(:juan)
    @new_opinion = user.opinions.create(title: 'Me, robot', body: ('nil' * 4000))
    assert_equal(@new_opinion.valid?, false)
  end

  test 'new opinion is created' do
    user = users(:juan)
    @new_opinion = user.opinions.create(title: 'Me, robot',
                                        body: 'Good book for humans and robots')
    assert_equal(@new_opinion.valid?, true)
  end
end
