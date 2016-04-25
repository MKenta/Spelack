Rails.application.routes.draw do
  root 'channels#index'
  devise_for :users
  resources :channels, only: [:index, :new, :create, :show]
end
