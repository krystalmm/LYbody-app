require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe '#new' do
    it 'responds successfully' do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#show' do
    before { sign_in user }
    it 'responds successfully' do
      get mypage_path
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

  describe '#edit' do
    before { sign_in user }

    it 'responds successfully' do
      get edit_information_path
      expect(response).to have_http_status(:success)
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

    it 'fails update user with wrong information' do
      patch users_information_path, params: { user: {
        firstname: ' ', lastname: ' ', kana_firstname: ' ', kana_lastname: ' ',
        email: 'test@invalid', phone_number: '111222'
      } }
      expect(response).to have_http_status(200)
    end
  end

  describe '#unsubscribe' do
    before { sign_in user }

    it 'responds successfully' do
      get unsubscribe_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#withdraw' do
    before { sign_in user }

    it 'succeeds withdraw user' do
      patch withdraw_path
      expect(response).to redirect_to root_path
      expect(user.is_valid).to eq false
    end
  end

  describe 'before_action: :authenticate_user' do
    it 'redirects mypage when not logged in' do
      get mypage_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'redirects edit when not logged in' do
      get edit_information_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'redirects update when not logged in' do
      patch users_information_path, params: { user: {
        firstname: 'テスト', lastname: 'ユーザー', kana_firstname: 'テスト', kana_lastname: 'ユーザー',
        email: 'testuser@example.com', phone_number: '01022223333'
      } }
      expect(response).to redirect_to new_user_session_path
    end

    it 'redirects unsubscribe when not logged in' do
      get unsubscribe_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'redirects withdraw when not logged in' do
      patch withdraw_path
      expect(response).to redirect_to new_user_session_path
    end
  end
end
