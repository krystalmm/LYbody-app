class Instructors::LessonsController < ApplicationController
  before_action :authenticate_instructor!

  def create
    @lesson = current_instructor.lessons.new(lesson_params)
    if current_instructor.save
      redirect_to instructors_path, notice: 'レッスンが追加されました。'
    else
      redirect_to instructors_path
      flash[:danger] = 'レッスンが入力されていません。'
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
  end

  private

  def lesson_params
    params.require(:lesson).permit(:lesson)
  end
end
