class Public::ReservationsController < ApplicationController

  def index
    @instructor = Instructor.find(params[:instructor_id])
    @reservations = Reservation.where(instructor_id: @instructor.id)
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :instructor_id, :start_time)
  end
end
