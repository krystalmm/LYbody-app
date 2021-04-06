class Instructors::InstructorsController < ApplicationController
  before_action :authenticate_instructor!

  def show
    @instructor = current_instructor
    @lesson = Lesson.new
  end
end
