Rails.application.routes.draw do
  root 'users#index'
  # devise_for :users, :controllers => { :confirmations => "my/confirmations" }
  namespace 'api' do
    get 'messages/index'
    get 'messages/show'
    resources :messages, only: %i(index show)
    get 'channels/index'
    resources :channels, only: :index
    resources :users, only: :index
  end
  devise_for :users, controllers: { registrations: "registrations" }
  resources :channels
  resources :messages, only: %i(index create update destroy)
  resources :search_channels, only: :index
  resources :join_channels, only: :index
  get 'users/after_sign_up'

  mount ActionCable.server => '/cable'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
