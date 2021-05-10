require 'rails_helper'

RSpec.describe 'Rooms', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:room) { FactoryBot.create(:room, user_id: user.id) }

  describe '#show' do
    before { sign_in user }

    it 'responds successfully' do
      get room_path(room)
      expect(response).to have_http_status(:success)
    end
  end

  describe '#pagination' do
    before { sign_in user }

    it 'responds successfully' do
      get room_pagination_path(room, 2), xhr: true
      expect(response).to have_http_status(:success)
    end
  end

  describe 'before_action: :authenticate_user' do
    it 'redirects show when not logged in' do
      get room_path(room)
      expect(response).to redirect_to new_user_session_path
    end

    it 'redirects pagination when not logged in' do
      get room_pagination_path(room, 2)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
