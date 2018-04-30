Rails.application.routes.draw do

  root "static_pages#home"
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :users, only: [:index, :show]
  resources :requests
  resources :applies, only: [:create, :destroy]
  resources :diplomas, only: [ :create, :destroy]
  resources :conversations, only: [:new ,:create, :show, :update]
  put "close_conversation", to: "conversations#close"
  resources :messages, only: [:create]
  resources :comments, only: [:create]

  mount ActionCable.server, at: '/cable'
  mount RailsAdmin::Engine => "/admin", as: :rails_admin
end
