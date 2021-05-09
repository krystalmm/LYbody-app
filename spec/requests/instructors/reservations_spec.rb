require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  let(:instructor) { FactoryBot.create(:instructor) }
  let!(:reservation) { FactoryBot.create(:reservation, instructor_id: instructor.id) }

  describe '#update' do
    before { sign_in instructor }

    it 'succeeds update reservation with valid datetime' do
      patch instructors_reservation_path(reservation), params: { reservation: FactoryBot.attributes_for(:reservation) }
      aggregate_failures do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to instructors_mypage_path
      end
    end
  end

  describe '#destroy' do
    before { sign_in instructor }

    it 'succeeds destroy reservation' do
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
