class Instructors::InstructorsController < ApplicationController
  before_action :authenticate_instructor!

  def show
    @instructor = current_instructor
    @lesson = Lesson.new
    @reviews = @instructor.reviews.includes([:user])
    @reservations = @instructor.reservations.includes([:user])
  end
end
