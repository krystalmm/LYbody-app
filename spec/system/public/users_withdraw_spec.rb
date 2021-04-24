require 'rails_helper'

RSpec.describe 'UsersWithdraw', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
    click_link '※ 退会をご希望の方はこちら'
    click_link '退会する'
  end

  it 'succeeds dismissed with correct_user' do
    aggregate_failures do
      expect(current_path).to eq root_path
      expect(has_css?('.alert-info')).to be_truthy
      expect(page).to have_content 'ありがとうございました。またのご利用をお待ちしております。'
      visit current_path
      expect(has_css?('.alert-info')).to be_falsy
    end
  end

  it 'fails login with dismissed user' do
    click_link 'ログイン'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'ログインする'
    aggregate_failures do
      expect(current_path).to eq new_user_session_path
      expect(has_css?('.alert-danger')).to be_truthy
      expect(page).to have_content 'お客様は退会済みです。申し訳ございませんが、別のメールアドレスをお使いください。'
    end
  end
end