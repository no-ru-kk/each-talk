Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'cards', to: 'users/registrations#new_card'
    post 'cards', to: 'users/registrations#create_card'
  end
  root 'rooms#index'
  resources :users, only: [:show, :update]
  resources :rooms
  resources :trooms, only: [:destroy] do
    resources :messages, only: [:index, :create]
  end
  resources :rooms, only: :order do
    post 'order', on: :member
  end
end