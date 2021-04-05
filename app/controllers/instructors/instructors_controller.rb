class Instructors::InstructorsController < ApplicationController
  before_action :authenticate_instructor!

  def show
  end
end
