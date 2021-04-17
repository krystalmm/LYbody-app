class Instructors::UsersController < ApplicationController
  before_action :authenticate_instructor!

  def index
    @users = User.where(is_payed: true).order(:id)
  end

  def show
    @user = User.find(params[:id])
  end
end
