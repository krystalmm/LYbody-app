class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def show
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
    end
    if @user.update(user_params)
      sign_in(@user, :bypass => true)
      redirect_to mypage_path, notice: 'ご登録情報の更新が完了しました。'
    else
      render :edit
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :kana_firstname, :kana_lastname, :email, :phone_number, :password)
  end
end
