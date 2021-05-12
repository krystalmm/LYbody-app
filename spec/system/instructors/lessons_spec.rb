require 'rails_helper'

RSpec.describe 'Lessons', type: :system, js: true do
  let(:lesson) { FactoryBot.create(:lesson) }
  let(:instructor) { FactoryBot.create(:instructor) }

  before do
    instructor_login_as(instructor)
  end

  it 'succeeds add lesson' do
    choose 'lesson_button_add_lesson'
    fill_in 'lesson_lesson', with: 'new_lesson'
    click_button 'レッスンを追加する'
    aggregate_failures do
      expect(current_path).to eq instructors_mypage_path
      expect(has_css?('.alert-success')).to be_truthy
      visit instructors_mypage_path
      expect(has_css?('.alert-success')).to be_falsy
      expect(page).to have_content 'new_lesson'
    end

    choose 'lesson_button_existing_lesson'
    select 'new_lesson', from: 'lesson[lesson_select]'
    click_button 'レッスンを追加する'
    aggregate_failures do
      expect(current_path).to eq instructors_mypage_path
      expect(has_css?('.alert-success')).to be_truthy
      expect(page).to have_content 'new_lesson'
    end
  end

  it 'fails add lesson' do
    choose 'lesson_button_add_lesson'
    fill_in 'lesson_lesson', with: ' '
    click_button 'レッスンを追加する'
    aggregate_failures do
      expect(current_path).to eq instructors_mypage_path
      expect(has_css?('.alert-danger')).to be_truthy
      visit instructors_mypage_path
      expect(has_css?('.alert-danger')).to be_falsy
    end
  end

  it 'succeeds delete lesson' do
    choose 'lesson_button_add_lesson'
    fill_in 'lesson_lesson', with: 'delete_lesson'
    click_button 'レッスンを追加する'
    visit instructors_mypage_path
    accept_alert do
      click_on '（削除する）'
    end
    aggregate_failures do
      expect(current_path).to eq instructors_mypage_path
      expect(has_css?('.alert-success')).to be_truthy
      visit instructors_mypage_path
      expect(has_css?('.alert-success')).to be_falsy
      expect(page).to_not have_content 'delete_lesson'
    end
  end
end
