class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)

    redirect_to new_user_registration_path and return unless card.present?

    customer = Payjp::Customer.retrieve(card.customer_token) 
    @card = customer.cards.first
    @room = Room.includes(:room_order).where(room_orders: {user_id: current_user.id} )
    @eroom = Room.includes(:user).where(user_id: current_user.id )
  end

  def update
    if current_user.update(user_params) 
      redirect_to user_path(current_user.id) 
    else
      redirect_to action: "show" 
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :email)
  end
end