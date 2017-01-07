Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#show"

  resources :session, only: [:create, :destroy]
  resources :chat_rooms, only: [:new, :create, :show, :index]
  resources :messages, only: [:create, :update, :destroy]

  # has to be mounted for the websockets
  mount ActionCable.server => '/cable'
end
