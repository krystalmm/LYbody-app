class Instructors::UsersController < ApplicationController
  before_action :authenticate_instructor!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
