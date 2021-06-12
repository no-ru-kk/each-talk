# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  def create
    @user = User.new(sign_up_params)
     unless @user.valid?
       render :new and return
     end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @card = @user.build_card
    render :new_card
  end

  def create_card
    @user = User.new(session["devise.regist_data"]["user"])
    card_data
      unless @card.valid?
        render :new_card and return
      end
    @user.build_card(@card.attributes)
    if @user.save
      session["devise.regist_data"]["user"].clear
      sign_in(:user, @user)
      redirect_to user_path(current_user.id)
    else
      render :new_card
    end
  end
 
  private

  def card_data
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    customer = Payjp::Customer.create(
    description: 'test', 
    card: params[:card_token] 
    )

    @card = Card.new( 
      card_token: customer.default_card, 
      customer_token: customer.id, 
      user_id: @user.id 
    )
  end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
