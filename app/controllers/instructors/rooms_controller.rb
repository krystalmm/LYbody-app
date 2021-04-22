class Instructors::RoomsController < ApplicationController
  before_action :authenticate_instructor!

  def show
    @room = Room.find_by(user_id: params[:id])

    if @room.nil?
      @room = Room.new(user_id: params[:id])
      @room.instructor_id = current_instructor.id
      redirect_to instructors_room_path(@room.id) if @room.save
    end

    @chat = Chat.new
    # 最新８件のデータを取得 desc
    @chats = @room.chats.order(created_at: "DESC").page(params[:page]).per(8)

    @footer_chat = true
  end

  # 新しくparams[:page]に合わせたデータを取得するメソッドを作成。
  # viewに.js.erbを作成して_chat-content.html.erbをrenderする
  def pagination
    @room = Room.find_by(instructor_id: params[:id])

    if @room.nil?
      @room = Room.new(instructor_id: params[:id])
      @room.user_id = current_user.id
      redirect_to room_path(@room.id) if @room.save
    end
    @chat = Chat.new

    @chats = @room.chats.order(created_at: "DESC").page(params[:page]).per(8)

    @footer_chat = true
  end
end
