Rails.application.routes.draw do

  namespace :auth do
    post 'google', to: 'auth#google'
  end

  get 'users', to: 'users#index'

  resources :conversations

  devise_for :users, path: '', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
