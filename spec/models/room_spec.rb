require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:room) { FactoryBot.create(:room) }

  it 'has a valid factory' do
    expect(room).to be_valid
  end

  it 'is invalid without a user_id' do
    room.user_id = nil
    expect(room).to be_invalid
  end

  it 'is invalid without a instructor_id' do
    room.instructor_id = nil
    expect(room).to be_invalid
  end
end
