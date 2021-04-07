class Instructors::LessonsController < ApplicationController
  before_action :authenticate_instructor!

  def create
    binding.pry
    if params[:lesson] == "existing_lesson"

    elsif params[:lesson] == "add_lesson"
      @lesson = current_instructor.lessons.new(lesson_params)
      if current_instructor.save
        redirect_to instructors_path, notice: 'レッスンが追加されました。'
      else
        redirect_to instructors_path
        flash[:danger] = 'レッスンが入力されていません。'
      end
    end
  end

  def destroy
    @lesson = current_instructor.lessons.find(params[:id])
    if @lesson.destroy
      redirect_to instructors_path, notice: 'レッスンを削除しました。'
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(:lesson)
  end
end
