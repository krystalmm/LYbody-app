require 'rails_helper'

RSpec.describe 'UsersLogin', type: :system, js: true do
  let(:user) { FactoryBot.create(:user) }

  it 'succeeds login when user submit valid information followed by logout' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'ログインする'
    aggregate_failures do
      expect(current_path).to eq mypage_path
      expect(page).to_not have_link 'ログイン'
      expect(page).to have_link 'マイページ', href: mypage_path
    end

    click_on 'ログアウト'
    aggregate_failures do
      expect(current_path).to eq root_path
      expect(page).to_not have_link 'マイページ'
      expect(page).to have_link 'ログイン', href: new_user_session_path
    end
  end

  it "can't login when user submit invalid information" do
    visit new_user_session_path
    fill_in 'user_email', with: 'invalid@email.com'
    fill_in 'user_password', with: 'invalidpassword'
    click_button 'ログインする'
    aggregate_failures do
      expect(current_path).to eq new_user_session_path
      expect(has_css?('.alert-danger')).to be_truthy
      visit current_path
      expect(has_css?('.alert-danger')).to be_falsy
    end
  end

  it 'succeeds login when click guest login link' do
    visit new_user_session_path
    click_on 'ゲストログイン'
    aggregate_failures do
      expect(current_path).to eq mypage_path
      expect(page).to have_content 'ゲストユーザーとしてログインしました。'
      expect(has_css?('.alert-success')).to be_truthy
      visit current_path
      expect(has_css?('.alert-success')).to be_falsy
    end
  end
end
