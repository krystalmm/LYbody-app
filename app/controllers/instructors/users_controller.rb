class Instructors::UsersController < ApplicationController
  before_action :authenticate_instructor!

  def index
    @users = User.all
  end

  def show

  end
end
