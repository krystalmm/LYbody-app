class Public::InstructorsController < ApplicationController
  def index
    @instructors = Instructor.where(has_lesson: true)
  end

  def show

  end
end
