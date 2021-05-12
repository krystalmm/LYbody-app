require 'rails_helper'

RSpec.describe 'UsersEdit', type: :system, js: true do
  let(:user) { FactoryBot.create(:user) }

  context 'when login as user' do
    before do
      login_as(user)
      click_link '登録情報を編集する'
    end

    it 'succeeds edit user information with correct information' do
      fill_in 'user_firstname', with: '令和'
      fill_in 'user_lastname', with: '道子'
      fill_in 'user_kana_firstname', with: 'レイワ'
      fill_in 'user_kana_lastname', with: 'ミチコ'
      fill_in 'user_email', with: 'reiwa@example.com'
      fill_in 'user_phone_number', with: '22233334444'
      click_button '編集内容を保存する'
      aggregate_failures do
        expect(current_path).to eq mypage_path
        expect(has_css?('.alert-success')).to be_truthy
        visit current_path
        expect(has_css?('.alert-success')).to be_falsy
      end
    end

    it 'fails edit with wrong information' do
      fill_in 'user_firstname', with: ' '
      fill_in 'user_lastname', with: ' '
      fill_in 'user_kana_firstname', with: ' '
      fill_in 'user_kana_lastname', with: ' '
      fill_in 'user_email', with: 'test@invalid'
      fill_in 'user_phone_number', with: '112222'
      click_button '編集内容を保存する'
      aggregate_failures do
        expect(current_path).to eq edit_information_path
        expect(page).to have_content '必須項目です'
      end
    end
  end

  context 'when login as guest user' do
    before do
      visit root_path
      click_link 'ゲストログイン'
    end

    it 'fails edit when logged in guest user' do
      expect(current_path).to eq mypage_path
      click_link '登録情報を編集する'
      fill_in 'user_firstname', with: 'ゲスト'
      fill_in 'user_lastname', with: 'ユーザー'
      fill_in 'user_kana_firstname', with: 'ゲスト'
      fill_in 'user_kana_lastname', with: 'ユーザー'
      fill_in 'user_email', with: 'guest@test.com'
      fill_in 'user_phone_number', with: '11122223333'
      click_button '編集内容を保存する'
      aggregate_failures do
        expect(current_path).to eq mypage_path
        expect(has_css?('.alert-danger')).to be_truthy
        expect(page).to have_content 'ゲストユーザーの更新はできません。'
        visit current_path
        expect(has_css?('.alert-danger')).to be_falsy
        expect(page).to_not have_content 'guest@test.com'
      end
    end
  end
end
