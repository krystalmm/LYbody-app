require 'rails_helper'

RSpec.describe 'Chats', type: :request do
  let(:instructor) { FactoryBot.create(:instructor) }
  let(:room) { FactoryBot.create(:room, instructor_id: instructor.id) }

  describe '#create' do
    before { sign_in instructor }

    it 'succeeds create chat message' do
      post instructors_chats_path, params: { chat: {
        is_user: false, room_id: room.id, message: 'new instructor message'
      }, format: :js }
      expect(response.body).to include 'new instructor message'
    end
  end

  describe 'before_action: :authenticate_instructor' do
    it 'redirects create when not logged in' do
      post instructors_chats_path, params: { chat: {
        is_user: false, room_id: room.id, message: 'new instructor message'
      } }
      expect(response).to redirect_to new_instructor_session_path
    end
  end
end
