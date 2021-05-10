require 'rails_helper'

RSpec.describe 'Chats', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:room) { FactoryBot.create(:room, user_id: user.id) }

  describe '#create' do
    before { sign_in user }

    it 'succeeds create chat message' do
      post chats_path, params: { chat: {
        is_user: true, room_id: room.id, message: 'new message'
      }, format: :js }
      expect(response.body).to include 'new message'
    end
  end

  describe 'before_action: :authenticate_user' do
    it 'redirects create when not logged in' do
      post chats_path, params: { chat: {
        is_user: true, room_id: room.id, message: 'new message'
      } }
      expect(response).to redirect_to new_user_session_path
    end
  end
end
