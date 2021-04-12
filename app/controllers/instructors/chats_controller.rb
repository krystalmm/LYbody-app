class Instructors::ChatsController < ApplicationController
  before_action :authenticate_instructor!

  def create
    @room = Room.find(params[:chat][:room_id])
    @chats = @room.chats.order(:created_at)
    @chat = Chat.new(chat_params)
    respond_to do |format|
      if @chat.save
        format.js
      end
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:room_id, :is_user, :message)
  end
end
