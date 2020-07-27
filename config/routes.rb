Rails.application.routes.draw do
  devise_for :users
  root to: 'home#top'
  get 'home/about'
  resources :users, only: [:show, :edit, :update, :index]
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
end
