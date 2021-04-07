class Public::InstructorsController < ApplicationController
  def index
    @instructors = Instructor.all
  end

  def show

  end
end
