class Instructors::ReservationsController < ApplicationController
  before_action :authenticate_instructor!
  before_action :set_reservation

  def update
    if @reservation.update(reservation_params)
      @reservation.update(end_time: @reservation.set_end_time)
      redirect_to instructors_mypage_path, notice: "予約の変更が完了しました。"
    else
      flash[:danger] = "予約時間（開始時間）は現在の日時より遅い時間を選択してください。"
      redirect_to instructors_mypage_path
    end
  end

  def destroy
    return unless @reservation.destroy

    redirect_to instructors_mypage_path, notice: "予約を削除しました。"
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_time)
  end
end
