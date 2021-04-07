class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, notice: 'ご登録情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    current_user.update(is_valid: false)
    reset_session
    flash[:info] = "ありがとうございました。またのご利用をお待ちしております。"
    redirect_to root_path
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :kana_firstname, :kana_lastname, :email, :phone_number, :password)
  end
end
