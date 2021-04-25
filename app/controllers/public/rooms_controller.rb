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
    chat_scope = @room.chats.order(:created_at)
    @chats = reverse_paginate(chat_scope, params[:page])
    if params[:page].present?
      @page = params[:page]
    else
      @page = 1
    end

    @footer_chat = true
  end


  def pagination
    @room = Room.find_by(instructor_id: params[:id])

    if @room.nil?
      @room = Room.new(instructor_id: params[:id])
      @room.user_id = current_user.id
      redirect_to room_path(@room.id) if @room.save
    end
    @chat = Chat.new

    chat_scope = @room.chats.order(:created_at)
    @chats = reverse_paginate(chat_scope, params[:page])
    if params[:page].present?
      @page = params[:page]
    else
      @page = 1
    end

    @footer_chat = true
  end

  def reverse_paginate(scope, page)
    if page
      page_number = page
    else
      page_number = Kaminari.paginate_array(scope.reverse).page(1).per(8).max_pages
    end
    Kaminari.paginate_array(scope.reverse).page(page_number).per(8).reverse!
  end
end
