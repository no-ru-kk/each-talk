class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_room,           only:   [:show, :edit, :update, :destroy, :order]
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
    @room.destroy
    redirect_to root_path
  end

  def order
    redirect_to new_user_registration_path and return unless current_user.card.present?
    buy_room

    RoomOrder.create(user_id: current_user.id, room_id: params[:id],)

    redirect_to user_path(current_user.id)
  end

  private

  def room_params
    params.require(:room).permit(:name, :rexplain, :dayotw_id, :rtime_id, :htime_id, :mtime_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def judge_user
    unless current_user.id == @room.user_id && @room.room_order == nil
      redirect_to action: :index
    end
  end

  def buy_room
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @room.price,
      customer: customer_token,
      currency: 'jpy' 
    )
  end
end