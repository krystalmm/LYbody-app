require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:reservation) { FactoryBot.create(:reservation) }

  it 'has a valid factory' do
    expect(reservation).to be_valid
  end

  it 'is invalid without a user_id' do
    reservation.user_id = nil
    expect(reservation).to be_invalid
  end

  it 'is invalid with a duplicate user_id' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:reservation, user_id: user.id)
    reservation = FactoryBot.build(:reservation, user_id: user.id)
    expect(reservation).to be_invalid
  end

  it 'is invalid with a duplicate start_time scope: :instructor' do
    instructor = FactoryBot.create(:instructor)
    FactoryBot.create(:reservation, instructor_id: instructor.id, start_time: DateTime.current + 2.hour, end_time: DateTime.current + 3.hour)
    reservation = FactoryBot.build(:reservation, instructor_id: instructor.id, start_time: DateTime.current + 2.hour, end_time: DateTime.current + 3.hour)
    expect(reservation).to be_invalid
  end

  it 'is invalid without an end_time' do
    reservation.end_time = ""
    expect(reservation).to be_invalid
  end

  it 'is invalid when start_time > end_time' do
    reservation = FactoryBot.build(:reservation, start_time: DateTime.current + 3.hour, end_time: DateTime.current + 2.hour)
    expect(reservation).to be_invalid
  end

  it 'is invalid when start_time < DateTime.current' do
    reservation = FactoryBot.build(:reservation, start_time: DateTime.current, end_time: DateTime.current + 1.hour)
    expect(reservation).to be_invalid
  end
end
