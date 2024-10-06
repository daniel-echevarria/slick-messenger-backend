Rails.application.routes.draw do
  get "users/index"
  resources :users
  devise_for :users, path: '',
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
