class Instructors::ReviewsController < ApplicationController
  before_action :authenticate_instructor!

  def destroy
    review = Review.find(params[:id])
    if review.destroy
      redirect_to instructors_mypage_path, notice: 'レビューが削除されました。'
    end
  end
end
