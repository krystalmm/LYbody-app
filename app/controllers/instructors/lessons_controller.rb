class Instructors::LessonsController < ApplicationController
  before_action :authenticate_instructor!

  def create
    case params[:lesson_button]
    when 'existing_lesson'
      @lesson = current_instructor.lessons.new(lesson: params[:lesson][:lesson_select])
    when 'add_lesson'
      @lesson = current_instructor.lessons.new(lesson_params)
    end
    if current_instructor.save
      current_instructor.update(has_lesson: true) if current_instructor.has_lesson == false
      redirect_to instructors_mypage_path, notice: 'レッスンが追加されました。'
    else
      @instructor = current_instructor
      @reviews = @instructor.reviews
      render 'instructors/instructors/show'
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    return unless @lesson.destroy

    current_instructor.update(has_lesson: false) if current_instructor.lessons.blank?
    redirect_to instructors_mypage_path, notice: 'レッスンを削除しました。'
  end

  private

  def lesson_params
    params.require(:lesson).permit(:lesson)
  end
end
