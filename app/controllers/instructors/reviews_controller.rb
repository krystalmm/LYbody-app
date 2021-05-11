class Instructors::ReviewsController < ApplicationController
  before_action :authenticate_instructor!

  def destroy
    review = Review.find(params[:id])
    redirect_to instructors_mypage_path, notice: 'レビューが削除されました。' if review.destroy
  end
end
