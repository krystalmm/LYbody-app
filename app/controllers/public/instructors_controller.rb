class Public::InstructorsController < ApplicationController
  def index
    @instructors = Instructor.where(has_lesson: true).order(:id).page(params[:page])
                             .includes([:instructor_lessons]).includes([:lessons]).per(4)
  end

  def show
    @instructor = Instructor.find(params[:id])
    @review = Review.new
    @reviews = @instructor.reviews.includes([:user])
    return unless current_user

    @room = Room.find_by(user_id: current_user.id, instructor_id: @instructor.id)
    return unless @room.nil?

    @room = Room.new(user_id: current_user.id)
    @room.instructor_id = @instructor.id
    @room.save
  end
end
