class Public::InstructorsController < ApplicationController
  def index
    @instructors = Instructor.where(has_lesson: true).order(:id)
  end

  def show
    @instructor = Instructor.find(params[:id])
    @review = Review.new
  end
end
