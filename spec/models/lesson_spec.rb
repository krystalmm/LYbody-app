require 'rails_helper'

RSpec.describe Lesson, type: :model do
  let(:lesson) { FactoryBot.create(:lesson) }

  it 'has a valid factory' do
    expect(lesson).to be_valid
  end

  it 'is invalid without a lesson' do
    lesson.lesson = ''
    expect(lesson).to be_invalid
  end

  it 'does not have too long lesson' do
    lesson.lesson = 'a' * 51
    expect(lesson).to be_invalid
  end
end
