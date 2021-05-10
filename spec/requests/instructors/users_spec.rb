require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:instructor) { FactoryBot.create(:instructor) }
  let!(:user) { FactoryBot.create(:user) }

  describe '#index' do
    before { sign_in instructor }

    it 'responds successfully' do
      get instructors_users_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#show' do
    before { sign_in instructor }

    it 'responds successfully' do
      get instructors_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'before_action: :authenticate_instructor' do
    it 'redirects index when not logged in' do
      get instructors_users_path
      expect(response).to redirect_to new_instructor_session_path
    end

    it 'redirects show when not logged in' do
      get instructors_user_path(user)
      expect(response).to redirect_to new_instructor_session_path
    end
  end
end
