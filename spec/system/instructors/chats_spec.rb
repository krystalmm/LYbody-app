require 'rails_helper'

RSpec.describe 'Chats', type: :system, js: true do
  let(:user) { FactoryBot.create(:user) }
  let(:instructor) { FactoryBot.create(:instructor) }
  let(:room) { FactoryBot.create(:room, user_id: user.id, instructor_id: instructor.id) }

  before do
    instructor_login_as(instructor)
    visit instructors_room_path(room)
  end

  it 'succeeds create chat' do
    fill_in 'chat-textarea', with: 'create chat'
    click_button '送信'
    aggregate_failures do
      expect(current_path).to eq instructors_room_path(room)
      expect(page).to have_css('p', text: 'create chat')
    end
  end

  it 'fails create chat' do
    fill_in 'chat-textarea', with: ' '
    click_button '送信'
    aggregate_failures do
      expect(current_path).to eq instructors_room_path(room)
      expect(page).to_not have_css('p', text: ' ')
    end
  end
end