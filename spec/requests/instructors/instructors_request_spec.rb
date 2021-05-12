require 'rails_helper'

RSpec.describe 'Instructors', type: :request do
  let(:instructor) { FactoryBot.create(:instructor) }

  describe '#show' do
    before { sign_in instructor }

    it 'responds successfully' do
      get instructors_mypage_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'before_action: :authenticate_instructor' do
    it 'redirects show when not logged in' do
      get instructors_mypage_path
      expect(response).to redirect_to new_instructor_session_path
    end
  end
end
