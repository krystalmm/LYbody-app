class Instructors::LessonsController < ApplicationController
  before_action :authenticate_instructor!

  def create
    if params[:lesson_button] == "existing_lesson"
      @lesson = current_instructor.lessons.new(lesson: params[:lesson][:lesson_select])
    elsif params[:lesson_button] == "add_lesson"
      @lesson = current_instructor.lessons.new(lesson_params)
    end
    if current_instructor.save
      current_instructor.update(has_lesson: true) if current_instructor.has_lesson == false
      redirect_to instructors_mypage_path, notice: 'レッスンが追加されました。'
    else
      @instructor = current_instructor
      render 'instructors/instructors/show'
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    if @lesson.destroy
      current_instructor.update(has_lesson: false) if current_instructor.lessons.blank?
      redirect_to instructors_mypage_path, notice: 'レッスンを削除しました。'
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(:lesson)
  end
end
