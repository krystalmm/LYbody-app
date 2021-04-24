require 'rails_helper'

RSpec.describe 'Reservations', type: :system, js: true do
  let(:user) { FactoryBot.create(:user) }
  let(:instructor) { FactoryBot.create(:instructor) }

  context 'when reservation date is not today or tommorow' do
    before do
      FactoryBot.create(:reservation, user_id: user.id, instructor_id: instructor.id, start_time: DateTime.current + 5, end_time: DateTime.current + 6)
      login_as(user)
    end

    it 'succeeds update reservation' do
      click_button '予約日時を変更する'
      select '19', from: "reservation[start_time(4i)]"
      click_button '変更する'
      aggregate_failures do
        expect(current_path).to eq mypage_path
        expect(has_css?('.alert-success')).to be_truthy
        visit current_path
        expect(has_css?('.alert-success')).to be_falsy
        expect(page).to have_content '19 : 00 ~ 20 : 00'
      end
    end

    it 'succeeds destroy reservation' do
      accept_alert do
        click_link '予約をキャンセルする'
      end
      aggregate_failures do
        expect(current_path).to eq mypage_path
        expect(has_css?('.alert-success')).to be_truthy
        visit current_path
        expect(has_css?('.alert-success')).to be_falsy
        expect(page).to have_content '現在レッスンのご予約はございません。'
      end
    end
  end

  context 'when reservation date is today or tommorow' do
    before do
      FactoryBot.create(:reservation, user_id: user.id, instructor_id: instructor.id)
      login_as(user)
    end

    it 'fails update reservation' do
      click_button '予約日時を変更する'
      select '19', from: "reservation[start_time(4i)]"
      click_button '変更する'
      aggregate_failures do
        expect(current_path).to eq mypage_path
        expect(has_css?('.alert-danger')).to be_truthy
        expect(page).to have_content 'ご予約日前日（当日）の変更をご希望の方は、ご予約されたレッスンのインストラクターまでご連絡して頂きますようお願い致します。'
        visit current_path
        expect(has_css?('.alert-danger')).to be_falsy
      end
    end

    it 'fails destroy reservation' do
      accept_alert do
        click_link '予約をキャンセルする'
      end
      aggregate_failures do
        expect(current_path).to eq mypage_path
        expect(has_css?('.alert-danger')).to be_truthy
        expect(page).to have_content 'ご予約日前日（当日）のキャンセルをご希望の方は、ご予約されたレッスンのインストラクターまでご連絡して頂きますようお願い致します。'
        visit current_path
        expect(has_css?('.alert-danger')).to be_falsy
      end
    end
  end
end