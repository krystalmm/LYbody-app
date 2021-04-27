class Public::InstructorsController < ApplicationController
  def index
    @instructors = Instructor.where(has_lesson: true).order(:id).page(params[:page]).per(4)
  end

  def show
    @instructor = Instructor.find(params[:id])
    @review = Review.new
    if current_user
      @room = Room.find_by(user_id: current_user.id, instructor_id: @instructor.id)
      if @room.nil?
        @room = Room.new(user_id: current_user.id)
        @room.instructor_id = @instructor.id
        redirect_to instructors_room_path(@room.id) if @room.save #public
      end
    end
  end
end
