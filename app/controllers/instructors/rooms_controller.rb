class Instructors::RoomsController < ApplicationController
  before_action :authenticate_instructor!

  def show
    @room = Room.find_by(user_id: params[:id])

    if @room.nil?
      @room = Room.new(user_id: params[:id])
      @room.instructor_id = current_instructor.id
      if @room.save
        redirect_to instructors_room_path(@room.id)
      end
    end

    @chat = Chat.new
    @chats = @room.chats.order(:created_at)

    @footer_chat = true
  end
end
