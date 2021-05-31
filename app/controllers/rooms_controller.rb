class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_room,           only:   [:show, :edit, :update, :destroy]
  before_action :judge_user,         only:   [:edit, :update, :destroy]

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

  def show
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to room_path(@room.id)
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def room_params
    params.require(:room).permit(:name, :rexplain, :dayotw_id, :rtime_id, :htime_id, :mtime_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def judge_user
    unless current_user.id == @room.user_id
    # unless current_user.id == @room.user_id && @room.order == nil
      redirect_to action: :index
    end
  end
end