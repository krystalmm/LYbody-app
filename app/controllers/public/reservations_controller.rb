class Public::ReservationsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_reservation, only: %i[update destroy]
  before_action :invalid_datetime, only: %i[update create]
  before_action :redirects_update_today_or_tomorrow, only: [:update]

  def index
    @instructor = Instructor.find(params[:instructor_id])
    @reservations = Reservation.where(instructor_id: @instructor.id)
    @reservation = Reservation.new
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.set_end_time
    respond_to do |format|
      if @reservation.save
        format.js { flash[:notice] = 'レッスンの予約が完了しました。' }
      else
        format.js { render :errors }
      end
    end
  end

  def update
    if @reservation.update(reservation_update_params)
      @reservation.update(end_time: @reservation.set_end_time)
      redirect_to mypage_path, notice: '予約の変更が完了しました。'
    else
      flash[:danger] = '予約の変更ができませんでした。変更をご希望の方は、ご予約されたレッスンのインストラクターまでご連絡して頂きますようお願い致します。'
      redirect_to mypage_path
    end
  end

  def destroy
    # 予約日前日と当日はキャンセル不可
    if @reservation.start_time < DateTime.current.since(2.days)
      flash[:danger] = 'ご予約日前日（当日）のキャンセルをご希望の方は、ご予約されたレッスンのインストラクターまでご連絡して頂きますようお願い致します。'
      redirect_to mypage_path
      return
    end

    return unless @reservation.destroy

    redirect_to mypage_path, notice: '予約を削除しました。'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :instructor_id, :start_time)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_update_params
    params.require(:reservation).permit(:start_time)
  end

  def invalid_datetime
    return if Date.valid_date?(params[:reservation]['start_time(1i)'].to_i, params[:reservation]['start_time(2i)'].to_i,
                               params[:reservation]['start_time(3i)'].to_i)

    respond_to do |format|
      format.js { render :date_valid }
      format.html { redirect_to mypage_path, danger: '日付の値が不正です。' }
    end
  end

  # rubocop:disable Metrics/AbcSize
  # 予約日前日と当日は変更不可
  def redirects_update_today_or_tomorrow
    selected_day = DateTime.new(params[:reservation]['start_time(1i)'].to_i, params[:reservation]['start_time(2i)'].to_i,
                                params[:reservation]['start_time(3i)'].to_i, params[:reservation]['start_time(4i)'].to_i,
                                params[:reservation]['start_time(5i)'].to_i)
    return unless selected_day < DateTime.current.since(2.days)

    flash[:danger] = 'ご予約日前日（当日）の変更をご希望の方は、ご予約されたレッスンのインストラクターまでご連絡して頂きますようお願い致します。'
    redirect_to mypage_path
  end
  # rubocop:enable Metrics/AbcSize
end
