require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  let(:instructor) { FactoryBot.create(:instructor) }
  let!(:review) { FactoryBot.create(:review, instructor_id: instructor.id) }

  describe '#destroy' do
    before { sign_in instructor }

    it 'succeeds delete review' do
      aggregate_failures do
        expect do
          delete instructors_review_path(review)
        end.to change(Review, :count).by(-1)
        expect(response).to redirect_to instructors_mypage_path
      end
    end
  end

  describe 'before_action: :authenticate_instructor' do
    it 'redirects destroy when not logged in' do
      delete instructors_review_path(review)
      expect(response).to redirect_to new_instructor_session_path
    end
  end
end
