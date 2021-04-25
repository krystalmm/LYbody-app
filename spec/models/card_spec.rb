require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:card) { FactoryBot.create(:card) }

  it 'has a valid factory' do
    expect(card).to be_valid
  end

  it 'is invalid without a customer_id' do
    card.customer_id = ""
    expect(card).to be_invalid
  end

  it 'is invalid without a card_id' do
    card.card_id = ""
    expect(card).to be_invalid
  end

  it 'is invalid without a user_id' do
    card.user_id = nil
    expect(card).to be_invalid
  end
end
