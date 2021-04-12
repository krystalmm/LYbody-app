class Public::ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.find(params[:chat][:room_id])
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to room_path(@room)
    else
      redirect_to room_path(@room)
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:room_id, :is_user, :message)
  end
end
