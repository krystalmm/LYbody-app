class Public::RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @room = Room.find(params[:id])

    @chat = Chat.new
    chat_scope = @room.chats.order(:created_at)
    @chats = reverse_paginate(chat_scope, params[:page])
    @page = params[:page].presence || 1

    @footer_chat = true
  end

  def pagination
    @room = Room.find(params[:id])

    @chat = Chat.new
    chat_scope = @room.chats.order(:created_at)
    @chats = reverse_paginate(chat_scope, params[:page])
    @page = params[:page].presence || 1

    @footer_chat = true
  end

  def reverse_paginate(scope, page)
    page_number = page || Kaminari.paginate_array(scope.reverse).page(1).per(10).max_pages
    Kaminari.paginate_array(scope.reverse).page(page_number).per(10).reverse!
  end
end
