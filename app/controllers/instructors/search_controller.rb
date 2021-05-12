class Instructors::SearchController < ApplicationController
  before_action :authenticate_instructor!

  def search
    @users = User.looks(params[:word]).page(params[:page]).per(10)
  end
end
