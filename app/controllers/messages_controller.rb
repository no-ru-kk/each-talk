class MessagesController < ApplicationController
  
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    unless @room.room_order != nil 
      redirect_to user_path(current_user.id)
    else
      @troom = Troom.find(params[:troom_id])
      @messages = @troom.messages.includes(:user)
      judge_user
    end
  end

  def create
    @room = Room.find(params[:room_id])
    @troom = Troom.find(params[:troom_id])
    @message = @troom.messages.new(message_params)
    if @message.save
      redirect_to room_troom_messages_path(@room, @troom)
    else
      @messages = @troom.messages.includes(:user)
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

  def judge_user
    unless current_user.id == @room.user_id || current_user.id == @room.room_order.user_id
      redirect_to root_path
    end
  end
end

