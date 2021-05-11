require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  let(:instructor) { FactoryBot.create(:instructor) }
  let!(:reservation) { FactoryBot.create(:reservation, instructor_id: instructor.id) }

  describe '#update' do
    before { sign_in instructor }

    it 'succeeds update reservation with valid datetime' do
      patch instructors_reservation_path(reservation), params: { reservation: {
        "start_time(1i)": DateTime.current.year.to_s, "start_time(2i)": (DateTime.current.month + 1).to_s, "start_time(3i)": '10', "start_time(4i)": '17', "start_time(5i)": '00'
      } }
      aggregate_failures do
        expect(response).to redirect_to instructors_mypage_path
        expect(reservation.reload.start_time.in_time_zone).to eq "#{DateTime.current.year}-#{DateTime.current.month + 1}-10 17:00".in_time_zone
      end
    end

    it 'fails update reservation with invalid datetime' do
      patch instructors_reservation_path(reservation), params: { reservation: {
        "start_time(1i)": (DateTime.current.year + 1).to_s, "start_time(2i)": '02', "start_time(3i)": '31', "start_time(4i)": '17', "start_time(5i)": '00'
      } }
      aggregate_failures do
        expect(response).to redirect_to instructors_mypage_path
        expect(reservation.reload.start_time.in_time_zone).to_not eq "#{DateTime.current.year + 1}-02-31 17:00".in_time_zone
      end
    end

    it 'fails update reservation when start_time < now' do
      patch instructors_reservation_path(reservation), params: { reservation: {
        "start_time(1i)": '2021', "start_time(2i)": '01', "start_time(3i)": '19', "start_time(4i)": '17', "start_time(5i)": '00'
      } }
      aggregate_failures do
        expect(response).to redirect_to instructors_mypage_path
        expect(reservation.reload.start_time.in_time_zone).to_not eq '2021-01-19 17:00'.in_time_zone
      end
    end
  end

  describe '#destroy' do
    before { sign_in instructor }

    it 'succeeds delete reservation' do
      aggregate_failures do
        expect do
          delete instructors_reservation_path(reservation)
        end.to change(Reservation, :count).by(-1)
        expect(response).to redirect_to instructors_mypage_path
      end
    end
  end

  describe 'before_action: :authenticate_instructor' do
    it 'redirects update when not logged in' do
      patch instructors_reservation_path(reservation), params: { reservation: FactoryBot.attributes_for(:reservation) }
      expect(response).to redirect_to new_instructor_session_path
    end

    it 'redirects destroy when not logged in' do
      delete instructors_reservation_path(reservation)
      expect(response).to redirect_to new_instructor_session_path
    end
  end
end
