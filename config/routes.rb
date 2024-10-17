Rails.application.routes.draw do
  namespace :auth do
    post 'google', to: 'auth#google'
  end

  get 'current', to: 'users#current'
  get 'users', to: 'users#index'

  resources :conversations
  resources :friendships
  resources :messages
  resources :profiles

  devise_for :users, path: '', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
