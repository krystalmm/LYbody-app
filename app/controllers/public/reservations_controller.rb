class Public::ReservationsController < ApplicationController

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
        format.js { flash[:notice] = "レッスンの予約が完了しました。" }
      else
        format.js { render :errors }
      end
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :instructor_id, :start_time)
  end
end
