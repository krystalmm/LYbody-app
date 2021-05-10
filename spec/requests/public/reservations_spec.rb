require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:instructor) { FactoryBot.create(:instructor) }

  describe '#index' do
    it 'responds successfully' do
      get "/reservations?instructor_id=#{instructor.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    before { sign_in user }

    it 'succeeds create reservation with valid datetime' do
      aggregate_failures do
        expect do
          post reservations_path, params: { reservation: {
            user_id: user.id, instructor_id: instructor.id, "start_time(1i)": "#{DateTime.current.year}", "start_time(2i)": "#{DateTime.current.month + 1}", "start_time(3i)": "01", "start_time(4i)": "17", "start_time(5i)": "00"
          }, format: :js }
        end.to change(Reservation, :count).by(1)
        expect(response.body).to include 'レッスンの予約が完了しました。'
      end
    end

    it 'fails create reservation with invalid datetime' do
      aggregate_failures do
        expect do
          post reservations_path, params: { reservation: {
            user_id: user.id, instructor_id: instructor.id, "start_time(1i)": "#{DateTime.current.year + 1}", "start_time(2i)": "02", "start_time(3i)": "31", "start_time(4i)": "17", "start_time(5i)": "00"
          }, format: :js }
        end.to change(Reservation, :count).by(0)
        expect(response.body).to include '日付の値が不正です。'
      end
    end

    it 'fails create reservation when start_time < now' do
      aggregate_failures do
        expect do
          post reservations_path, params: { reservation: {
            user_id: user.id, instructor_id: instructor.id, "start_time(1i)": "2021", "start_time(2i)": "01", "start_time(3i)": "19", "start_time(4i)": "17", "start_time(5i)": "00"
          }, format: :js }
        end.to change(Reservation, :count).by(0)
        expect(response.body).to include '予約時間（開始時間）は現在の日時より遅い時間を選択してください。'
      end
    end
  end

  describe '#update' do
    let!(:reservation) { FactoryBot.create(:reservation, user_id: user.id, instructor_id: instructor.id) }

    before { sign_in user }

    it 'succeeds update reservation' do
      patch reservation_path(reservation), params: { reservation: {
        user_id: user.id, instructor_id: instructor.id, "start_time(1i)": "#{DateTime.current.year}", "start_time(2i)": "#{DateTime.current.month + 1}", "start_time(3i)": "10", "start_time(4i)": "17", "start_time(5i)": "00"
      } }
      aggregate_failures do
        expect(response).to redirect_to mypage_path
        expect(reservation.reload.start_time.to_time).to eq "#{DateTime.current.year}-#{DateTime.current.month + 1}-10 17:00".to_time
      end
    end

    it 'fails update reservation with invalid datetime' do
      patch reservation_path(reservation), params: { reservation: {
        user_id: user.id, instructor_id: instructor.id, "start_time(1i)": "#{DateTime.current.year + 1}", "start_time(2i)": "02", "start_time(3i)": "31", "start_time(4i)": "17", "start_time(5i)": "00"
      } }
      aggregate_failures do
        expect(response).to redirect_to mypage_path
        expect(reservation.reload.start_time.to_time).to_not eq "#{DateTime.current.year + 1}-02-31 17:00".to_time
      end
    end

    it 'fails update reservation when start_time < now' do
      patch reservation_path(reservation), params: { reservation: {
        user_id: user.id, instructor_id: instructor.id, "start_time(1i)": "2021", "start_time(2i)": "01", "start_time(3i)": "19", "start_time(4i)": "17", "start_time(5i)": "00"
      } }
      aggregate_failures do
        expect(response).to redirect_to mypage_path
        expect(reservation.reload.start_time.to_time).to_not eq '2021-01-19 17:00'.to_time
      end
    end
  end

  describe '#destroy' do
    let!(:reservation) { FactoryBot.create(:reservation, user_id: user.id, instructor_id: instructor.id) }

    before { sign_in user }

    it 'succeeds delete reservation' do
      aggregate_failures do
        expect do
          delete reservation_path(reservation)
        end.to change(Reservation, :count).by(-1)
        expect(response).to redirect_to mypage_path
      end
    end
  end

  describe 'before_action: :authenticate_user' do
    let!(:reservation) { FactoryBot.create(:reservation, user_id: user.id, instructor_id: instructor.id) }

    it 'redirects create when not logged in' do
      post reservations_path, params: { reservation: {
        user_id: user.id, instructor_id: instructor.id, "start_time(1i)": "#{DateTime.current.year}", "start_time(2i)": "#{DateTime.current.month + 1}", "start_time(3i)": "01", "start_time(4i)": "17", "start_time(5i)": "00"
      } }
      expect(response).to redirect_to new_user_session_path
    end

    it 'redirects update when not logged in' do
      patch reservation_path(reservation), params: { reservation: {
        user_id: user.id, instructor_id: instructor.id, "start_time(1i)": "#{DateTime.current.year}", "start_time(2i)": "#{DateTime.current.month + 1}", "start_time(3i)": "10", "start_time(4i)": "17", "start_time(5i)": "00"
      } }
      expect(response).to redirect_to new_user_session_path
    end

    it 'redirects destroy when not logged in' do
      delete reservation_path(reservation)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
