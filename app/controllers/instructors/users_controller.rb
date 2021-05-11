class Instructors::UsersController < ApplicationController
  before_action :authenticate_instructor!

  def index
    @users = case params[:option]
             when 'payed'
               User.where(is_payed: true).page(params[:page]).per(10).order(:id)
             else
               User.page(params[:page]).per(10).order(:id)
             end
  end

  def show
    @user = User.find(params[:id])
    @room = Room.find_by(user_id: @user.id, instructor_id: current_instructor.id)
    return unless @room.nil?

    @room = Room.new(user_id: @user.id)
    @room.instructor_id = current_instructor.id
    @room.save
  end
end
