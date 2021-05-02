class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_instructor

  def create
    review = current_user.reviews.new(review_params)
    review.instructor_id = @instructor.id
    review.score = Language.get_data(review_params[:comment])
    respond_to do |format|
      if review.save
        format.js { flash[:notice] = 'レビューの投稿が完了しました' }
      else
        format.js { render :errors }
      end
    end
  end

  def destroy
    review = Review.find_by(id: params[:id], instructor_id: @instructor.id)
    respond_to do |format|
      if review.destroy
        format.html { redirect_to mypage_path, notice: 'レビューが削除されました。' }
        format.js { flash[:notice] = 'レビューが削除されました。' }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment)
  end

  def set_instructor
    @instructor = Instructor.find(params[:instructor_id])
  end
end
