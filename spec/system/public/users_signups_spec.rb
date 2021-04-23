require 'rails_helper'

RSpec.describe 'UsersSignups', type: :system, js: true do
  it 'succeeds signup when user submit valid information' do
    visit new_user_registration_path
    fill_in 'user_firstname', with: 'Test'
    fill_in 'user_lastname', with: 'User'
    fill_in 'user_kana_firstname', with: 'テスト'
    fill_in 'user_kana_lastname', with: 'ユーザー'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_phone_number', with: '11122223333'
    fill_in 'password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button '登録する'
    aggregate_failures do
      expect(current_path).to eq mypage_path
      expect(has_css?('.alert-success')).to be_truthy
      visit current_path
      expect(has_css?('.alert-success')).to be_falsy
    end
  end

  it "can't signup when user submit invalid information" do
    visit new_user_registration_path
    fill_in 'user_firstname', with: ' '
    fill_in 'user_lastname', with: ' '
    fill_in 'user_kana_firstname', with: 'kanafirst'
    fill_in 'user_kana_lastname', with: 'kanalast'
    fill_in 'user_email', with: 'test@invalid'
    fill_in 'user_phone_number', with: '1112222'
    fill_in 'password', with: 'foo'
    fill_in 'user_password_confirmation', with: 'bar'
    click_button '登録する'
    aggregate_failures do
      expect(current_path).to eq new_user_registration_path
      expect(page).to have_content '必須項目です'
    end
  end
end