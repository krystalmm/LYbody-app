require 'rails_helper'

RSpec.describe 'InstructorsLogin', type: :request do
  let(:instructor) { FactoryBot.create(:instructor) }

  describe '#new' do
    it 'responds successfully' do
      get new_instructor_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    it 'succeeds login with valid information' do
      post instructor_session_path, params: { instructor: {
        email: instructor.email, password: instructor.password
      } }
      expect(response).to redirect_to instructors_mypage_path
    end

    it 'fails login with invalid information' do
      post instructor_session_path, params: { instructor: {
        email: 'invalid@example.com', password: 'invalidpassword'
      } }
      expect(response.body).to include 'メールアドレスまたはパスワードが違います。'
    end
  end

  describe '#destroy' do
    it 'succeeds logout' do
      post instructor_session_path, params: { instructor: {
        email: instructor.email, password: instructor.password
      } }
      delete destroy_instructor_session_path
      expect(response).to redirect_to new_instructor_session_path
    end
  end

  describe 'instructor guest login' do
    it 'succeeds login' do
      FactoryBot.create(:instructor, id: 1)
      post instructors_guest_sign_in_path
      expect(response).to redirect_to instructors_mypage_path
    end
  end
end
