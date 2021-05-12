require 'rails_helper'

RSpec.describe 'Lessons', type: :request do
  let(:instructor) { FactoryBot.create(:instructor) }
  let!(:lesson) { FactoryBot.create(:lesson) }

  describe '#create' do
    before { sign_in instructor }

    it 'succeeds create new lesson with valid information' do
      expect do
        post instructors_lessons_path, params: { lesson_button: 'add_lesson', lesson: {
          lesson: 'new lesson'
        } }
      end.to change(Lesson, :count).by(1)
      expect(response).to redirect_to instructors_mypage_path
    end

    it 'succeeds add existing lesson' do
      expect do
        post instructors_lessons_path, params: { lesson_button: 'existing_lesson', lesson: {
          lesson_select: 'Lesson'
        } }
      end.to change(Lesson, :count).by(1)
      expect(response).to redirect_to instructors_mypage_path
    end

    it 'fails create new lesson with invalid information' do
      expect do
        post instructors_lessons_path, params: { lesson_button: 'add_lesson', lesson: {
          lesson: ' '
        } }
      end.to change(Lesson, :count).by(0)
      expect(response.body).to include 'レッスンを入力してください'
    end
  end

  describe '#destroy' do
    before { sign_in instructor }

    it 'succeeds delete lesson' do
      aggregate_failures do
        expect do
          delete instructors_lesson_path(lesson)
        end.to change(Lesson, :count).by(-1)
        expect(response).to redirect_to instructors_mypage_path
      end
    end
  end

  describe 'before_action: :authenticate_instructor' do
    it 'redirects create when not logged in' do
      post instructors_lessons_path, params: { lesson_button: 'add_lesson', lesson: {
        lesson: 'new lesson'
      } }
      expect(response).to redirect_to new_instructor_session_path
    end

    it 'redirects destroy when not logged in' do
      delete instructors_lesson_path(lesson)
      expect(response).to redirect_to new_instructor_session_path
    end
  end
end
