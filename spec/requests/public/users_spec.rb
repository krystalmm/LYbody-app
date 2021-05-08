require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe '#new' do
    it 'responds successfully' do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    it 'succeeds create a new user with correct signup information' do
      user_params = FactoryBot.attributes_for(:user)
      aggregate_failures do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to mypage_path
      end
    end
  end

  describe '#update' do
    before { sign_in user }

    it 'succeeds update user with correct information' do
      patch users_information_path, params: { user: {
        firstname: 'テスト', lastname: 'ユーザー', kana_firstname: 'テスト', kana_lastname: 'ユーザー',
        email: 'testuser@example.com', phone_number: '01022223333'
      } }
      expect(response).to redirect_to mypage_path
      expect(user.reload.email).to eq 'testuser@example.com'
    end

  end
end
