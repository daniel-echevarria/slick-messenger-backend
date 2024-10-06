Rails.application.routes.draw do
  namespace :auth do
    post 'google', to: 'auth#google'
  end
  resources :users
  devise_for :users, path: '',
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
