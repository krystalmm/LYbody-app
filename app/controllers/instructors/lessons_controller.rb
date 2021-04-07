class Instructors::LessonsController < ApplicationController
  before_action :authenticate_instructor!

  def create
    if params[:lesson_button] == "existing_lesson"
      @lesson = current_instructor.lessons.new(lesson: params[:lesson][:lesson_select])
    elsif params[:lesson_button] == "add_lesson"
      @lesson = current_instructor.lessons.new(lesson_params)
    end
    if current_instructor.save
      redirect_to instructors_path, notice: 'レッスンが追加されました。'
    else
      @instructor = current_instructor
      render 'instructors/instructors/show'
    end
  end

  def destroy
    @lesson = current_instructor.instructor_lessons.find_by(lesson_id: params[:id])
    if @lesson.destroy
      redirect_to instructors_path, notice: 'レッスンを削除しました。'
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(:lesson)
  end
end
