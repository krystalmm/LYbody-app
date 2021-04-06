class Instructors::InstructorsController < ApplicationController
  before_action :authenticate_instructor!
  before_action :set_current_instructor

  def show
  end

  private

  def set_current_instructor
    @instructor = current_instructor
  end
end
