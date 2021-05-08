require 'rails_helper'

RSpec.describe 'UsersLogin', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe '#new' do
    it 'responds successfully' do
      get new_user_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    it 'succeeds login with valid information' do
      post user_session_path, params: { user: {
        email: user.email, password: user.password
      } }
      expect(response).to redirect_to mypage_path
    end

    it 'fails login with a dismissed user' do
      dismissed_user = FactoryBot.create(:user, :invalid_user)
      post user_session_path, params: { user: {
        email: dismissed_user.email, password: dismissed_user.password
      } }
      expect(response).to redirect_to new_user_session_path
    end

    it 'fails login with invalid information' do
      post user_session_path, params: { user: {
        email: 'invalid@example.com', password: 'invalidpassword'
      } }
      expect(response.body).to include 'メールアドレスまたはパスワードが違います。'
    end
  end

  describe '#destroy' do
    it 'succeeds logout' do
      post user_session_path, params: { user: {
        email: user.email, password: user.password
      } }
      delete destroy_user_session_path
      expect(response).to redirect_to root_path
    end
  end
end
