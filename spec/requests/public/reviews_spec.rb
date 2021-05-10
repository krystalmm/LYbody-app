require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:instructor) { FactoryBot.create(:instructor) }
  let!(:review) { FactoryBot.create(:review, user_id: user.id, instructor_id: instructor.id) }

  describe "#create" do
    before { sign_in user }

    it 'succeeds create review with valid information' do
      aggregate_failures do
        expect do
          post instructor_reviews_path(instructor), params: { review: { comment: 'new review' }, format: :js }
        end.to change(Review, :count).by(1)
        expect(response.body).to include 'new review'
      end
    end

    it 'fails create review with invalid information' do
      aggregate_failures do
        expect do
          post instructor_reviews_path(instructor), params: { review: { comment: ' ' }, format: :js }
        end.to change(Review, :count).by(0)
        expect(response.body).to include '投稿内容を入力してください'
      end
    end
  end

  describe '#destroy' do
    before { sign_in user }

    it 'succeeds delete review' do
      aggregate_failures do
        expect do
          delete instructor_review_path(instructor, review)
        end.to change(Review, :count).by(-1)
        expect(response).to redirect_to mypage_path
      end
    end
  end

  describe 'before_action: :authenticate_user' do
    it 'redirects create when not logged in' do
      post instructor_reviews_path(instructor), params: { review: { comment: 'new review' } }
      expect(response).to redirect_to new_user_session_path
    end

    it 'redirects destroy when not logged in' do
      delete instructor_review_path(instructor, review)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
