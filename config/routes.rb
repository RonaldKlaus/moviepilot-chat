Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#show"

  resources :chat_rooms, only: [:new, :create, :show, :index]
  resources :messages

  # has to be mounted for the websockets
  mount ActionCable.server => '/cable'
end
