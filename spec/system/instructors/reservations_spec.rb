require 'rails_helper'

RSpec.describe 'Reservations', type: :system, js: true do
  let(:instructor) { FactoryBot.create(:instructor) }
  let(:user) { FactoryBot.create(:user) }

  before do
    FactoryBot.create(:reservation, instructor_id: instructor.id, user_id: user.id)
    instructor_login_as(instructor)
  end

  it 'succeeds update reservation' do
    click_button '変更する'
    select '19', from: "reservation[start_time(4i)]"
    find('#modal-submit').click
    aggregate_failures do
      expect(current_path).to eq instructors_mypage_path
      expect(has_css?('.alert-success')).to be_truthy
      visit current_path
      expect(has_css?('.alert-success')).to be_falsy
      expect(page).to have_content '19 : 00 ~ 20 : 00'
      expect(page).to have_content user.fullname
    end
  end

  it 'fails update reservation when start_time < now' do
    click_button '変更する'
    select Time.current.month - 1, from: "reservation[start_time(2i)]"
    find('#modal-submit').click
    aggregate_failures do
      expect(current_path).to eq instructors_mypage_path
      expect(has_css?('.alert-danger')).to be_truthy
      visit current_path
      expect(has_css?('.alert-danger')).to be_falsy
    end
  end

  it 'fails update reservation when start_time is invalid date' do
    click_button '変更する'
    select '4', from: "reservation[start_time(2i)]"
    select '31', from: "reservation[start_time(3i)]"
    find('#modal-submit').click
    aggregate_failures do
      expect(current_path).to eq instructors_mypage_path
      expect(has_css?('.alert-danger')).to be_truthy
      expect(page).to have_content '日付の値が不正です。'
      visit current_path
      expect(has_css?('.alert-danger')).to be_falsy
    end
  end

  it 'succeeds delete reservation' do
    accept_alert do
      click_link '削除する'
    end
    aggregate_failures do
      expect(current_path).to eq instructors_mypage_path
      expect(has_css?('.alert-success')).to be_truthy
      expect(page).to have_content '予約を削除しました。'
      visit current_path
      expect(has_css?('.alert-success')).to be_falsy
    end
  end
end