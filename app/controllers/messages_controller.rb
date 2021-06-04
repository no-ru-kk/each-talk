class MessagesController < ApplicationController
  
  def index
    @message = Message.new
    @room = Room.find(params[:troom_id])
    unless @room.room_order != nil 
      redirect_to user_path(current_user.id)
    else
      @troom = Troom.find(params[:troom_id])
      @messages = @troom.messages.includes(:user)
    end
  end

  def create
    @troom = Troom.find(params[:troom_id])
    @message = @troom.messages.new(message_params)
    if @message.save
      redirect_to troom_messages_path(@troom)
    else
      @messages = @troom.messages.includes(:user)
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end