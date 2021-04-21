class Instructors::SearchController < ApplicationController
  def search
    @users = User.looks(params[:word]).page(params[:page]).per(10)
  end
end
