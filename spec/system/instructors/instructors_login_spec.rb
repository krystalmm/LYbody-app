require 'rails_helper'

RSpec.describe 'InstructorsLogin', type: :system, js: true do
  let(:instructor) { FactoryBot.create(:instructor) }

  it 'succeeds login when instructor submit valid information followed by logout' do
    visit new_instructor_session_path
    fill_in 'instructor_email', with: instructor.email
    fill_in 'instructor_password', with: instructor.password
    click_button 'ログインする'
    aggregate_failures do
      expect(current_path).to eq instructors_mypage_path
      expect(page).to_not have_link 'ログイン'
      expect(page).to have_link 'マイページ', href: instructors_mypage_path
    end

    click_on 'ログアウト'
    aggregate_failures do
      expect(current_path).to eq new_instructor_session_path
      expect(page).to_not have_link 'マイページ'
      expect(page).to have_link 'ログイン', href: new_user_session_path
    end
  end

  it "can't login when instructor submit invalid information" do
    visit new_instructor_session_path
    fill_in 'instructor_email', with: 'invalid@email.com'
    fill_in 'instructor_password', with: 'invalidpassword'
    click_button 'ログインする'
    aggregate_failures do
      expect(current_path).to eq new_instructor_session_path
      expect(has_css?('.alert-danger')).to be_truthy
      visit current_path
      expect(has_css?('.alert-danger')).to be_falsy
    end
  end
end