class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :ensure_normal_user, only: [:update]

  def show
    @reservation = Reservation.find_by(user_id: current_user.id)
    @reviews = @user.reviews.includes([:instructor])
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, notice: 'ご登録情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def unsubscribe; end

  def withdraw
    @user.update(is_valid: false)
    reset_session
    flash[:info] = 'ありがとうございました。またのご利用をお待ちしております。'
    redirect_to root_path
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :kana_firstname, :kana_lastname, :email, :phone_number,
                                 :password, :icon_image)
  end

  def ensure_normal_user
    if @user.email == 'guest@example.com'
      flash[:danger] = 'ゲストユーザーの更新はできません。'
      redirect_to mypage_path
    end
  end
end
