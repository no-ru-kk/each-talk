class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @room = Room.includes(:user).order("created_at DESC")
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :explain, :dayotw_id, :rtime_id, :htime_id, :mtime_id, :price, :image).merge(user_id: current_user.id)
  end
end