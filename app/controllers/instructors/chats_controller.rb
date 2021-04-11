class Instructors::ChatsController < ApplicationController
  before_action :authenticate_instructor!

  def create
    @room = Room.find(params[:chat][:room_id])
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to instructors_room_path(@room)
    else
      redirect_to instructors_room_path(@room)
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:room_id, :is_user, :message)
  end
end
