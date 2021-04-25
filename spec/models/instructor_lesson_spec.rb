require 'rails_helper'

RSpec.describe InstructorLesson, type: :model do
  let(:instructor_lesson) { FactoryBot.create(:instructor_lesson) }

  it 'has a valid factory' do
    expect(instructor_lesson).to be_valid
  end

  it 'is invalid without instructor_id' do
    instructor_lesson.instructor_id = nil
    expect(instructor_lesson).to be_invalid
  end

  it 'is invalid without lesson_id' do
    instructor_lesson.lesson_id = nil
    expect(instructor_lesson).to be_invalid
  end
end
