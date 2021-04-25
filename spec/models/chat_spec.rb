require 'rails_helper'

RSpec.describe Chat, type: :model do
  let(:chat) { FactoryBot.create(:chat) }

  it 'has a valid factory' do
    expect(chat).to be_valid
  end

  it 'is invalid without a message' do
    chat.message = ""
    expect(chat).to be_invalid
  end

  it 'is invalid when is_user is nil' do
    chat.is_user = nil
    expect(chat).to be_invalid
  end

  it 'is valid when is_user is true' do
    chat.is_user = true
    expect(chat).to be_valid
  end

  it 'is valid when is_user is false' do
    chat.is_user = false
    expect(chat).to be_valid
  end

  it 'is invalid without a room_id' do
    chat.room_id = nil
    expect(chat).to be_invalid
  end
end
