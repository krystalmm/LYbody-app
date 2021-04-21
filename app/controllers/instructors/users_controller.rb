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
  end
end
