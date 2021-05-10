require 'rails_helper'

RSpec.describe 'Rooms', type: :request do
  let(:instructor) { FactoryBot.create(:instructor) }
  let(:room) { FactoryBot.create(:room, instructor_id: instructor.id) }

  describe '#show' do
    before { sign_in instructor }

    it 'responds successfully' do
      get instructors_room_path(room)
      expect(response).to have_http_status(:success)
    end
  end

  describe '#pagination' do
    before { sign_in instructor }

    it 'responds successfully' do
      get instructors_room_pagination_path(room, 2), xhr: true
      expect(response).to have_http_status(:success)
    end
  end

  describe 'before_action: :authenticate_instructor' do
    it 'redirects show when not logged in' do
      get instructors_room_path(room)
      expect(response).to redirect_to new_instructor_session_path
    end

    it 'redirects pagination when not logged in' do
      get instructors_room_pagination_path(room, 2)
      expect(response).to redirect_to new_instructor_session_path
    end
  end
end
