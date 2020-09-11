require 'rails_helper'

RSpec.describe Opinion, type: :model do
  fixtures :users, :followings, :opinions
  context 'validation tests' do
    it 'ensures that it has a title' do
      new_opinion = Opinion.new(title: nil, body: 'Text')
      expect(new_opinion.valid?).to eq(false)
    end

    it 'ensures that it has a body' do
      new_opinion = Opinion.new(title: nil, body: 'Text')
      expect(new_opinion.valid?).to eq(false)
    end
  end

  context 'scope tests' do
    it 'returns the opinions of a user' do
      user = users(:juan)
      opinions = Opinion.user_opinions(user)
      opinion = opinions(:juan_opinion_one)
      expect(opinions).to include(opinion)
    end

    it 'doesn\'t return the opinions of other user' do
      user = users(:juan)
      opinions = Opinion.user_opinions(user)
      opinion = opinions(:yearin_opinion_one)
      expect(opinions).to_not include(opinion)
    end

    it 'returns opinions of user' do
      user = users(:juan)
      opinions = Opinion.last_opinions(user)
      opinion = opinions(:juan_opinion_three)
      expect(opinions).to include(opinion)
    end

    it 'returns opinions of followee' do
      user = users(:juan)
      opinions = Opinion.last_opinions(user)
      opinion = opinions(:yearin_opinion_three)
      expect(opinions).to include(opinion)
    end

    it 'doesn\'t returns opinions of not following users' do
      user = users(:juan)
      opinions = Opinion.last_opinions(user)
      opinion = opinions(:pedro_opinion_one)
      expect(opinions).to_not include(opinion)
    end
  end

  context 'method tests' do

    it 'replaces white space with plus sign' do
      opinion = opinions(:juan_opinion_one)
      expect(opinion.modify_title).to eq('Old+book')
    end

    it 'removes non-alphanumeric signs' do
      opinion = opinions(:pedro_opinion_one)
      expect(opinion.modify_title).to eq('Get+more+followers')
    end
  end
end
