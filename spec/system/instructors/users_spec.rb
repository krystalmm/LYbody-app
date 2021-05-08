# ユーザーのindexとshow
require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:instructor) { FactoryBot.create(:instructor) }

  before do
    instructor_login_as(instructor)
  end

  it 'succeeds show users page' do
    user = FactoryBot.create(:user)
    visit instructors_users_path
    aggregate_failures do
      expect(page).to have_content '会員一覧'
      expect(page).to have_content user.fullname
      expect(page).to have_content user.email
    end
  end

  it 'succeeds show user detail page' do
    user = FactoryBot.create(:user)
    visit instructors_users_path
    click_link user.fullname
    aggregate_failures do
      expect(page).to have_content "#{user.fullname}さんの詳細"
      expect(page).to have_content user.kana_fullname
      expect(page).to have_content user.email
      expect(page).to have_content user.phone_number
    end
  end
end
