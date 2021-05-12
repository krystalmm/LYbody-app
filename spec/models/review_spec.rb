require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:review) { FactoryBot.create(:review) }

  it 'has a valid factory' do
    expect(review).to be_valid
  end

  it 'is invalid without a comment' do
    review.comment = ''
    expect(review).to be_invalid
  end

  it 'does not have too long comment' do
    review.comment = 'a' * 801
    expect(review).to be_invalid
  end

  it 'is invalid without an instructor_id' do
    review.instructor_id = nil
    expect(review).to be_invalid
  end

  it 'is invalid without a user_id' do
    review.user_id = nil
    expect(review).to be_invalid
  end
end
