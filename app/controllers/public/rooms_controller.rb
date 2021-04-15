class Public::RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @room = Room.find_by(instructor_id: params[:id])

    if @room.nil?
      @room = Room.new(instructor_id: params[:id])
      @room.user_id = current_user.id
      redirect_to room_path(@room.id) if @room.save
    end

    @chat = Chat.new
    @chats = @room.chats.order(:created_at)

    @footer_chat = true
  end
end
